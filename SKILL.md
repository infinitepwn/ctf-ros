---
name: ctf-ros
description: Provides offensive and defensive techniques for ROS, ROS 2 and robotics targets. Use when a challenge, lab or engagement involves ROS graph reconnaissance, ROS Master XML-RPC, DDS/RTPS discovery, SROS2 keystores, rosbridge web bridges, MAVLink drones, industrial cobots (Universal Robots, KUKA, ABB, MiR), robot firmware or debug interfaces, or adversarial perception/ML on a robot. Also covers RCTF-style robot CTFs, Gazebo/Alurity lab builds, vendor robot CVE lookup, and hardening against IEC 62443. Do not use for generic Linux privesc, plain web challenges, or firmware reverse engineering that has no robotics middleware layer - use ctf-pwn, ctf-web or ctf-reverse instead.
license: MIT
compatibility: Requires a filesystem-based agent (Claude Code or similar) with bash, Python 3, and network access to the lab or CTF target. ROS 1/ROS 2 CLI tools are needed for live-graph work.
allowed-tools: Bash Read Write Edit Glob Grep Task WebFetch WebSearch Skill
metadata:
  user-invocable: "true"
  argument-hint: "[target-ip | disk-image | challenge-dir]"
  source: https://github.com/iotsrg/awesome-ros-security
---

# ROS & Robotics Security

A robot is a cyber-physical system: nodes exchanging sensor and actuation messages over a
middleware (ROS, DDS, or vendor-proprietary), running an embedded OS, often bridged to a cloud
fleet manager and an industrial network. A compromise is not just data theft - it can drive a
drone into the ground or a mobile robot into a person.

**Authorization first.** Only ever touch your own hardware, an explicitly authorized lab or a CTF
target. Exploit against simulators unless the engagement puts real hardware in scope and states a
stop condition. Tell the user which of the three you are in if it is not obvious.

## How to use this skill

Start with the router below, then work through steps 0-5. Each step names the reference file that
holds the depth. Do not read every reference file up front; load the one the current step needs.

| Reference | Use it for |
|---|---|
| [recon.md](recon.md) | Attack surface by layer, ROS 1/ROS 2 recon, the six pentest checklists (network, hardware, firmware/OS, application, auth/web, AI) |
| [tooling.md](tooling.md) | Pentest tools, DDS/RTPS and MAVLink analysers, exploitation frameworks, fuzzing, SBOM, forensics |
| [ctf-and-labs.md](ctf-and-labs.md) | Robot CTF challenges, spinning up a safe lab, simulators, learning hardware |
| [cves-and-incidents.md](cves-and-incidents.md) | Vendor CVE catalogue (ROS 1, ROS 2/Nav2/DDS, MiR, UR, KUKA, ABB, Unitree, drones) and published incidents |
| [hardening.md](hardening.md) | SROS2 / DDS-Security setup, standards (IEC 62443 and friends), hardening quick wins, perception/AI defence |
| [resources.md](resources.md) | Papers, conference talks, vendor research blogs, books, courses, communities, disclosure channels |

## Step 0 - Identify which layer you are attacking

Robots fail at seven layers; the fastest path is to name yours before running anything.

| What you were handed | First move | Go to |
|---|---|---|
| A reachable IP / flat network segment | Port sweep for 11311 (ROS 1 master), 7400-7500 UDP (RTPS), 9090 (rosbridge), vendor web UIs | [recon.md](recon.md), checklist 1 |
| A PCAP or a live DDS segment | Identify DDS vendor, then read topics straight from traffic - no ROS install needed | [tooling.md](tooling.md) |
| A firmware image / SD card / disk | Binwalk, mount, look for `/etc/ros`, launch files, keystores, credentials | [recon.md](recon.md) checklist 3, then ctf-reverse / ctf-forensics |
| Source or a ROS package | Static review of launch files, params, service handlers; SBOM for known CVEs | [tooling.md](tooling.md), [cves-and-incidents.md](cves-and-incidents.md) |
| A web dashboard / REST / WebSocket bridge | Treat as a normal web target first (OWASP), then abuse the rosbridge hop | ctf-web, then [recon.md](recon.md) checklist 5 |
| A perception model / sensor pipeline | Adversarial input, model tampering, sensor spoofing | ctf-ai-ml, then [hardening.md](hardening.md) |
| A drone or MAVLink link | Protocol-level command injection and telemetry replay | [tooling.md](tooling.md) |
| A robot CTF challenge bundle | Triage the artifact type inside the challenge | [ctf-and-labs.md](ctf-and-labs.md) |

## Step 1 - Know which ROS you are on

| | ROS 1 | ROS 2 |
|---|---|---|
| Transport | TCPROS / UDPROS over TCP + XML-RPC | DDS (RTPS), distributed, no master |
| Broker | Central `ROS Master` on TCP **11311** (XML-RPC) | None - discovery is peer to peer on UDP **7400-7500** |
| Authn / authz | None. Any node can register, publish, subscribe, or deregister others | Optional via DDS-Security, exposed as **SROS2** (PKI identity, signed permissions, AES-GCM) |
| Encryption | None, all plaintext | Only if SROS2 is actually enabled and policies are signed |
| Practical attack | Node spoofing, topic poisoning, XML-RPC injection, MITM | Misconfiguration: SROS2 off, wrong `ROS_DOMAIN_ID`, permissive `governance.xml`, missing access control |

ROS 2 security is *opt-in*. The default install is as open as ROS 1 on the same segment - the
attack surface merely moves from one master to every participant. Verify the state instead of
assuming it:

```bash
env | grep -E 'ROS_DOMAIN_ID|ROS_SECURITY|RMW_IMPLEMENTATION'
ros2 security list_enclaves 2>/dev/null || echo "no keystore / no SROS2 tooling reachable"
```

## Step 2 - Get on the graph

ROS 2 joins domain 0 by default, so a stock install on the same L2 segment is usually already
reachable without credentials. Point your CLI at the target domain and enumerate.

```bash
export ROS_DOMAIN_ID=0            # try 0..232; each domain is its own unauthenticated world
export RMW_IMPLEMENTATION=rmw_fastrtps_cpp   # match the target's vendor to see its traffic
ros2 node list && ros2 topic list -t && ros2 service list && ros2 param list
ros2 node info /<node> && ros2 topic echo /cmd_vel --once
```

ROS 1 is a single endpoint, so reconnaissance is one REST-ish call away.

```bash
export ROS_MASTER_URI=http://<target>:11311
rosnode list && rostopic list && rosservice list && rosparam list
rosnode info /<node> && rostopic echo -n1 /cmd_vel
```

If the CLI cannot see the graph but the port is open, the daemon, the domain id, or the DDS vendor
is wrong - not the network. Cross-check with a raw `ss -lunp` / packet capture before concluding
the target is clean.

## Step 3 - Fast wins, in the order they usually fall

1. **Unauthenticated graph access.** If `ros2 topic list` or `rostopic list` works from your
   machine, you already have read access to every sensor stream on that robot.
2. **Exposed ROS Master.** TCP 11311 reachable off-robot means the whole graph is enumerable and
   spoofable; look for it in `nmap -sT -p 11311`.
3. **rosbridge on 9090.** An unauthenticated WebSocket bridge turns one HTTP request into arbitrary
   publish/subscribe - often the shortest path from "web page" to "`/cmd_vel`".
4. **No keystore.** Absent SROS2 enclaves, unsigned governance, or `ROS_SECURITY_STRATEGY` not
   `Enforce` all mean DDS-Security is decoration.
5. **Parameter poisoning.** `ros2 param dump` / `rosparam list` plus write access to limits,
   speeds, and frame ids is control without touching a single topic.
6. **Launch-file secrets.** `/etc/ros/`, `~/.ros/` and `.launch`/`.yaml` files hold credentials,
   API keys, and vendor endpoints far more often than code does.
7. **Stale packages.** `rosdep`/apt/pip versions against the CVE table in
   [cves-and-incidents.md](cves-and-incidents.md); Syft + Grype if an SBOM is missing.
8. **Safety-topic exposure.** `/cmd_vel`, `/joint_states`, e-stop services - check whether the
   safety chain is actually a separate, authenticated path or just another topic.
9. **Debug interfaces left alive.** UART/JTAG/SSH/ADB on shipped robots; default vendor credentials.
10. **Domain leakage.** Several `ROS_DOMAIN_ID`s sharing one segment leak across teams, tenants, or
    safety islands.

Full ordered checklists (network, hardware, firmware/OS, application logic, auth/web, AI) live in
[recon.md](recon.md). Work them top to bottom and record evidence per item - a robot pentest report
is per-layer, not a story.

## Step 4 - From visibility to control

Only after the recon above, and only inside the authorized scope:

- **Node spoofing** - register a participant named like a trusted node and intercept or shadow it.
- **Topic poisoning** - publish plausible values on safety-critical or actuator topics; prefer
  harmless magnitudes (a slow `/cmd_vel` twist) over lethal ones.
- **Parameter / launch injection** - rewrite a param or a `.launch` to load your node on next boot.
- **MITM** - TCPROS/RTPS with no encryption; check whether the fleet manager authenticates the robot
  or the reverse.
- **Service abuse** - enumerate `rosservice`/`ros2 service` endpoints for unauthenticated command
  execution, motion override, and e-stop bypass; grep handlers for `os.system`/`subprocess`.
- **Deserialization and DoS** - fuzz custom `.msg` parsers, topic flooding, RTPS announcement spam.

Stop at proof. Recovering a flag, a screenshot of a controlled motion inside a simulator, or a
demonstrated unauthenticated publish is the deliverable - not a damaged robot.

## Step 5 - Report and hand off

- CTF: captured flag plus the exact request/command that produced it; hand off with
  [ctf-writeup](../ctf-writeup/SKILL.md).
- Engagement: map each finding to its layer and to an IEC 62443 / DDS-Security control, list the
  remediation from [hardening.md](hardening.md), and flag anything that is a *safety* issue rather
  than a security issue - those get escalated immediately, not in the report.
- Keep the tooling and versions used with the evidence so results are reproducible.

## Lab setup

Do not learn this on production hardware. Build on a simulator, or in a containerized robot
toolbox, and pin one ROS distro per scenario:

```bash
# Lab tooling (recommended set before an engagement)
sudo apt install -y nmap tcpdump wireshark tshark docker.io
pip install -r requirements.txt 2>/dev/null || pip install pyshark requests websockets
docker run --rm -it --network host alurity/alurity   # only after reading ctf-and-labs.md
```

Capability notes for your own box: ROS 2 CLI needs the distro sourced
(`source /opt/ros/<distro>/setup.bash`); ROS 1 needs `ROS_MASTER_URI`; DDS vendor choice
(`RMW_IMPLEMENTATION`) must match the target or you will be invisible on the graph.

## Related skills

- [solve-challenge](../solve-challenge/SKILL.md) - when you only know "some robot thing" is the target.
- [ctf-reverse](../ctf-reverse/SKILL.md) - firmware, vendor binaries, custom node bytecode.
- [ctf-web](../ctf-web/SKILL.md) - rosbridge, dashboards, REST/MQTT fleet APIs.
- [ctf-ai-ml](../ctf-ai-ml/SKILL.md) - adversarial perception, model extraction, VLA/LLM robot control.
- [ctf-forensics](../ctf-forensics/SKILL.md) - robot disk images, boot logs, sensor captures.
- [ctf-pwn](../ctf-pwn/SKILL.md) - memory corruption inside a node, embedded service, or driver.

## Attribution

Technique, tool and CVE references are condensed from
[iotsrg/awesome-ros-security](https://github.com/iotsrg/awesome-ros-security) (see also
[Alias Robotics RVD](https://github.com/aliasrobotics/RVD) for the robot vulnerability database).
Verify any vendor model, version and CVE against the vendor advisory before quoting it in a report.
