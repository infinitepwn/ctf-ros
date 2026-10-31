# ROS / Robotics Recon and Pentest Checklists

Everything in this file is for authorized labs, CTF ranges, and hardware you own
or have written permission to test. These probes publish on live topics and can
move a physical machine: never point them at a production robot cell.

## Attack Surface Map

| Layer | Components | Typical Weaknesses |
|---|---|---|
| Hardware | JTAG, UART, USB, SD, CAN, EtherCAT, I2C, SPI | Exposed debug ports, glitching, sensor spoofing |
| Firmware / OS | Embedded Linux (Ubuntu, Yocto), RTOS, bootloader | Default creds, world-writable files, missing secure boot |
| Middleware | ROS 1 master, ROS 2 / DDS, MQTT, ZeroMQ | No auth (ROS 1), DDS misconfig, plaintext topics |
| Application | ROS nodes, services, parameter server, .launch/.yaml | Param poisoning, node spoofing, deserialization bugs |
| Perception / AI | LiDAR, RGB/RGBD cameras, IMU, ML models | Adversarial inputs, sensor spoofing, model tampering |
| Network | Wi-Fi, 4G/5G, Ethernet, Bluetooth | Open services, weak Wi-Fi, no IT/OT segmentation |
| Cloud / Fleet | Vendor cloud, web dashboards, REST/MQTT bridges | OWASP Top 10, weak API auth, exposed endpoints |
| Physical / Safety | E-stops, safety PLCs, motor controllers | Bypassable safety logic, unsafe defaults |

A robot compromise is not data theft. It can crash drones, drive mobile robots
into people, or weld where there should not be a weld.

## ROS 1 vs ROS 2: What You Are Looking For

### ROS 1 - insecure by design

- Central ROS Master on **TCP 11311** (XML-RPC).
- **No authentication**: any node on the network can register, subscribe,
  publish, or de-register other nodes.
- **No encryption**: everything is plaintext over TCPROS/UDPROS.
- XML-RPC injection and node hijacking are trivial.
- Mitigations are network-layer only: VPN, VLAN segmentation, IPsec.

### ROS 2 - security is optional

- Transport is **DDS (RTPS)**: distributed, no master node.
- DDS-Security plugins (Authentication, Access Control, Cryptographic) provide
  PKI-based identity, signed permissions, AES-GCM encryption; exposed in ROS 2
  as **SROS2**.
- Failure modes to hunt for: SROS2 disabled in dev/prod, wrong `ROS_DOMAIN_ID`,
  missing access control policies, permissive `governance.xml`.

## Recon Workflow

**1. Fingerprint the stack.** ROS 1 or ROS 2, which DDS vendor (Fast-DDS,
Cyclone, RTI Connext), which OS (Ubuntu, Yocto), which distro. Version skew
decides which of the findings in cves-and-incidents.md apply.

**2. Find the listening services.** ROS 1 master and `rosbridge` are TCP; DDS
discovery is UDP.

```bash
ss -ltnp
ss -lunp
nmap -sV -p 11311,9090 <target>
nmap -sU -p 7400-7500 <target>
```

Port map as used in the source: **TCP 11311** ROS 1 Master XML-RPC, **TCP 9090**
`rosbridge` WebSocket, **UDP 7400-7500** DDS RTPS discovery.

**3. Enumerate the graph.** On ROS 1 every answer comes back unauthenticated:
the master will happily describe nodes you do not own.

```bash
rosnode list
rosnode info /talker
rostopic list
rosservice list
rosparam list
```

```bash
ros2 node list
ros2 node info /talker
ros2 topic list
ros2 topic echo /cmd_vel
ros2 interface show geometry_msgs/msg/Twist
ros2 param dump /talker
```

**4. Check domain segregation.** A unique non-default `ROS_DOMAIN_ID` is the
only thing separating two ROS 2 deployments on one flat network; a default
domain means your node joins the robot's graph on discovery.

**5. Check whether security is on.** If SROS2 / DDS-Security is enabled, look
for signed governance and permissions XML and least-privilege enclaves. If the
governance file is permissive or unsigned, the deployment is effectively open.

**6. Go active.** Node spoofing (register a malicious node with the master and
intercept topics), topic poisoning on safety-critical topics such as
`/cmd_vel` and `/joint_states`, then MITM on TCPROS / RTPS where no
encryption is enforced.

## Pentest Checklists

### 1. Network and ROS graph

- [ ] Identify ROS version (ROS 1 vs ROS 2) and middleware (Fast-DDS, Cyclone, RTI Connext).
- [ ] Scan for ROS Master XML-RPC on **TCP 11311**.
- [ ] Enumerate all topics, services, parameters: `rostopic list`, `rosservice list`, `rosparam list`.
- [ ] List active nodes and inspect their connections: `rosnode list` / `rosnode info`.
- [ ] For ROS 2: probe RTPS discovery on UDP **7400-7500**; enumerate with `ros2 node list`, `ros2 topic list`.
- [ ] Check `ROS_DOMAIN_ID` segregation and cross-domain leakage.
- [ ] Verify whether SROS2 / DDS-Security is enabled and whether governance/permissions XML are signed.
- [ ] Attempt node spoofing: register a malicious node with the master and intercept topics.
- [ ] Attempt topic poisoning on safety-critical topics (`/cmd_vel`, `/joint_states`).
- [ ] Test MITM on TCPROS / RTPS where no encryption is enforced.

### 2. Hardware

- [ ] Identify and probe JTAG, SWD, UART, USB-OTG, SD card interfaces.
- [ ] Attempt firmware dump via debug interface or SPI flash readout.
- [ ] Probe CAN / CANopen / EtherCAT buses for unauthenticated motion commands.
- [ ] Inspect I2C / SPI sensor lines for tamper or spoofing potential.
- [ ] Check for secure boot, signed firmware, and TPM/secure-element presence.

### 3. Firmware and OS

- [ ] Fingerprint OS (Ubuntu, Yocto, ROS distro).
- [ ] Test for default or hardcoded credentials (vendor, SSH, web UI).
- [ ] Look for SUID binaries, world-writable dirs, lax sudoers (CWE-276).
- [ ] Check for outdated apt/pip/rosdep packages with known CVEs.
- [ ] Verify an SBOM exists and is current; scan it with Syft + Grype.
- [ ] Test for race conditions in init scripts (CWE-362).
- [ ] Inspect `/etc/ros/`, `~/.ros/`, and launch files for hardcoded secrets.

### 4. Application and ROS graph logic

- [ ] Parameter server poisoning: read and write sensitive params.
- [ ] Launch file injection: substitute `.launch` / `.yaml` to load attacker nodes.
- [ ] Deserialization: fuzz custom `.msg` parsers, especially user-defined types.
- [ ] DoS: topic flooding, parameter storms, RTPS announcement spam.
- [ ] Service abuse: enumerate `rosservice` endpoints for unauthenticated command exec, e-stop bypass, motion override.
- [ ] Check for command injection in service handlers that shell out (`os.system`, `subprocess`).

### 5. Auth, access control, web

- [ ] Verify the ROS 1 deployment sits on an isolated, segmented network.
- [ ] Confirm SROS2 enclaves are scoped to least privilege.
- [ ] Robot web dashboard / REST / WebSocket bridge (`rosbridge_suite`): apply OWASP Top 10 (authN/Z, CSRF, IDOR, SSRF).
- [ ] Test `rosbridge` WebSocket on port **9090** for unauthenticated topic publishing.
- [ ] Check TLS hygiene on every HTTPS/MQTT endpoint.

### 6. AI and perception

- [ ] Inventory perception models (object detection, SLAM, voice).
- [ ] Test adversarial robustness of camera/LiDAR pipelines.
- [ ] Verify model file integrity (signatures, hashes) on disk.
- [ ] Check for unprotected model update / OTA channels.

## If You See X, Do Y

| Observation | Next step |
|---|---|
| TCP 11311 open | ROS 1 master: enumerate with `rosnode`/`rostopic`, then try node spoofing |
| UDP 7400-7500 answering | ROS 2 / DDS: check `ROS_DOMAIN_ID`, look for SROS2, try topic poisoning |
| TCP 9090 open | `rosbridge`: test WebSocket topic publishing without auth |
| Permissive or unsigned `governance.xml` | Treat DDS-Security as off; report as open graph |
| `/cmd_vel` or `/joint_states` writable | Highest-severity finding: unauthenticated actuation |
| Vendor web UI on the cell network | Pivot to OWASP Top 10 testing, check default creds |
| Physical ports reachable | Move to hardware checklist and firmware dump |

## Source

Distilled from the curated list at [iotsrg/awesome-ros-security](https://github.com/iotsrg/awesome-ros-security);
the same list is where tooling, CVE and paper entries in the sibling files come from.

## Related

- [tooling.md](tooling.md) - the tools behind each step above
- [cves-and-incidents.md](cves-and-incidents.md) - what a given version is known to be vulnerable to
- [hardening.md](hardening.md) - the controls that close each finding
- [ctf-and-labs.md](ctf-and-labs.md) - safe places to run these checks
