# ROS and Robotics CVEs and Incidents

The catalogue of what is already known to be broken, by vendor and component.
Use it after finger-printing a target (see recon.md): match the version you
found to the row here, do not re-derive the bug.

> Authoritative registry: [Robot Vulnerability Database (RVD)](https://github.com/aliasrobotics/RVD)
> by Alias Robotics, ~241 catalogued vulnerabilities plus ~265 tracked ROS 2 bug
> entries as of 2024. Verify current counts on the repo; the tables below are the
> subset with primary-source detail. CVE identifiers are reproduced as the upstream list
> publishes them (year prefixes included); confirm the ID and affected versions on NVD or the
> vendor advisory before quoting one in a report.

## ROS 1 Core (architectural, no CVE)

| ID | Description | Reference |
|---|---|---|
| Architectural | No authentication and no encryption in the ROS 1 computational graph; documented design choice, not a bug with a CVE | [SROS paper (White et al., 2016)](https://arxiv.org/abs/1611.07060), [DeMarinis et al., 2018](https://arxiv.org/abs/1808.03322) |
| Architectural | `rosbridge_suite` WebSocket bridge has no built-in authentication by default | [rosbridge docs](https://github.com/RobotWebTools/rosbridge_suite) |

## ROS 2 / Nav2 / DDS

| ID | Component | Description | Reference |
|---|---|---|---|
| CVE-2024-37861 | `nav2_amcl` (Nav2 Humble) | Buffer overflow via a crafted `.yaml`, leading to RCE | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2024-37861) |
| CVE-2024-41648 | `navigation2` (Humble) | Insecure file permissions enable arbitrary code execution | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2024-41648) |
| CVE-2022-30262 | RTI Connext Pro / Fast-DDS / OpenDDS / Cyclone-DDS | RTPS parser denial of service | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2022-30262) |
| 2022 DDS RTPS bug cluster | All major DDS vendors | A series of related RTPS implementation flaws across vendors, disclosed together | [Alias Robotics writeup](https://news.aliasrobotics.com/alias-robotics-dds-ros2-vulnerabilities/) |

## MiR (Mobile Industrial Robots) and Easy Robotics

| ID | Description | Reference |
|---|---|---|
| CVE-2020-10271 | MiR ROS computational graph exposed to the network; an attacker can take control of robot logic | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2020-10271) |
| CVE-2020-10275 | REST API tokens derived from publicly documented default credentials | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2020-10275) |
| CVE-2020-10279 | Insecure Ubuntu defaults: race conditions (CWE-362), permission errors (CWE-276), default credentials; CVSS 9.8 | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2020-10279) |
| CVE-2020-10280 | Incomplete HTTP header flood DoS on the web dashboard (MiR and Easy Robotics) | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2020-10280) |

## Universal Robots (UR3 / UR5 / UR10 / UR+)

| ID | Description | Reference |
|---|---|---|
| CVE-2020-10266 | UR+ platform components installed with no integrity verification (CVSS 8.1, CWE-345/353) | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2020-10266) |
| CVE-2020-10290 | URCaps (Java zip apps) execute without permission restrictions on the controller (CVSS 6.8) | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2020-10290) |

## KUKA

| ID | Description | Reference |
|---|---|---|
| CVE-2020-10268 | KR C4 firmware/hardware: critical services can be terminated from Windows Task Manager, halting the manipulator (requires physical access, CVSS 6.1) | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2020-10268) |

## ABB

| ID | Description | Reference |
|---|---|---|
| CVE-2020-10287 | IRC5 family robots with the UAS service enabled ship with publicly documented default credentials | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2020-10287) |

## ROS 1 Packages

| ID | Description | Reference |
|---|---|---|
| CVE-2020-10289 | ROS `actionlib` allows arbitrary object instantiation via unsafe YAML load, giving RCE | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2020-10289) |

## Drone / UAV (MAVLink)

| ID | Description | Reference |
|---|---|---|
| CVE-2020-10281 | MAVLink v1.0 has no encryption by design; sensitive data travels cleartext (CWE-319) | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2020-10281) |
| CVE-2020-10283 | MAVLink v1.0 has no authentication; an attacker can force a downgrade from v2.0 during GCS-autopilot negotiation | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2020-10283) |

## Unitree (public research)

| ID / Target | Description | Reference |
|---|---|---|
| CVE-2025-2894 | Unitree Go1 backdoor: a hardcoded CloudSail API key enables full remote control without authentication | [SentinelOne advisory](https://www.sentinelone.com/vulnerability-database/cve-2025-2894/) |
| CVE-2026-27509 | Unitree Go2 unauthenticated DDS-based RCE via `rt/api/programming_actuator/request` (firmware V1.1.7-V1.1.11 EDU) | [boschko.ca write-up](https://boschko.ca/unitree-go2-rce/) |
| CVE-2026-27510 | Unitree Go2 mobile-app SQLite DB tampering enables persistent RCE bound to controller key combos | [boschko.ca write-up](https://boschko.ca/unitree-go2-rce/) |
| UniPwn (no CVE assigned at time of writing) | BLE Wi-Fi config service on Go2/B2/G1/H1 accepts the string `unitree` as a "secret", uses hardcoded encryption keys, and has unsanitized shell injection. Worm-capable: an infected robot scans BLE for other Unitree robots and compromises them. Disclosed Sept 2025 | [IEEE Spectrum (Sept 2025)](https://spectrum.ieee.org/unitree-robot-exploit), [Hackaday writeup](https://hackaday.com/2025/09/30/unitree-humanoid-robot-exploit-looks-like-a-bad-one/) |
| Unitree G1 fleet-wide Blowfish-ECB key | One static key reused across every G1 worldwide; effective entropy is zero bits once a single robot is reversed | [Mayoral-Vilches et al. 2025 (arXiv:2509.14139)](https://arxiv.org/abs/2509.14139) |

## SoftBank NAO / Pepper

The IOActive 2017-2018 *Hacking Robots Before Skynet* research documented about
50 flaws in NAO, Pepper, UR and Baxter. Not all received CVE assignments. See
the [IOActive paper](https://www.ioactive.com/wp-content/uploads/pdfs/Hacking-Robots-Before-Skynet.pdf)
and [technical appendix](https://www.ioactive.com/wp-content/uploads/pdfs/Hacking-Robots-Before-Skynet-Technical-Appendix.pdf)
for the full detail.

## Boston Dynamics Spot, Tesla Optimus (status note)

No specific public-research CVEs or peer-reviewed vulnerability reports were
verifiable at the time of writing. General "security concerns" think-pieces
exist but document no specific exploitable issue. Treat any claim of a Spot or
Optimus CVE as unverified until a primary source exists.

## Weakness Classes Without CVEs (industrial cells)

- **Remote control-parameter / calibration modification**: tiny offsets cause defective parts or unsafe motion (Trend Micro).
- **Safety PLC bypass**: light curtains, e-stops and safety zones are controlled by separately certified safety PLCs; check whether they are reachable or overridable from the standard network.
- **Network pivot**: a compromised cell controller is often the bridge from IT into the deep OT network.
- **Vendor remote-access tools** (KUKA WorkVisual, ABB RobotStudio, Fanuc Roboguide): historically weak authentication, often exposed for "remote support".
- **Fieldbuses**: EtherCAT, PROFINET, CANopen, EtherNet/IP are typically unauthenticated; treat them as inside the trust boundary.
- **OPC UA on robots**: increasingly common; check certificate validation and anonymous-access policies.

## Notable Incidents

| Year | Incident | Summary | Link |
|---|---|---|---|
| 2017 | Trend Micro Rogue Robots | First end-to-end attack chain on industrial arms (ABB, Kuka) | [Paper](https://documents.trendmicro.com/assets/wp/wp-industrial-robot-security.pdf) |
| 2018 | IOActive Hacking Robots Before Skynet | 50+ flaws in NAO, Pepper, UR, Baxter | [IOActive](https://act-on.ioactive.com/acton/attachment/34793/f-484f0d52-37bc-4313-a8ee-fc8b659d4b06/1/-/-/-/-/Hacking-Robots-Before-Skynet-Paper_Final.pdf) |
| 2019 | Alias Robotics RVD launch | The first public robot CVE registry | [Discourse](https://discourse.openrobotics.org/t/introducing-the-robot-vulnerability-database/11105) |
| 2020 | MiR / UR / ABB CVE wave | Coordinated disclosure of dozens of robot CVEs | [Alias as CNA](https://news.aliasrobotics.com/alias-robotics-as-cna-from-research-to-robotics-user-empowerment/) |
| 2022 | DDS RTPS bug class | A series of CVEs across all major DDS vendors | [Alias DDS](https://news.aliasrobotics.com/alias-robotics-dds-ros2-vulnerabilities/) |
| 2024 | Nav2 buffer overflow (CVE-2024-37861) | First RCE in the ROS 2 Nav stack via a crafted YAML | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2024-37861) |
| 2024 | RoboPAIR LLM jailbreak | UPenn shows LLM-controlled robots can be jailbroken into unsafe actions | [robopair.org](https://robopair.org/) |
| 2024-2025 | Humanoid robot reversing | Independent researchers reversing Unitree G1 and Tesla Optimus firmware | Various conference talks (see resources.md) |

## If You Fingerprint X, Check Y

| Fingerprint | Known issues to check |
|---|---|
| Nav2 Humble / `nav2_amcl` | CVE-2024-37861 (crafted YAML to RCE), CVE-2024-41648 (file permissions) |
| Any ROS 2 with RTI Connext Pro, Fast-DDS, OpenDDS or Cyclone-DDS | CVE-2022-30262 and the wider 2022 RTPS parser bug cluster |
| ROS 1 with `actionlib` | CVE-2020-10289 unsafe YAML load |
| `rosbridge_suite` on the graph | No default auth; unauthenticated publish path to every topic |
| MiR fleet on an open network | CVE-2020-10271 / -10275 / -10279 / -10280 |
| UR+ or URCaps on a UR controller | CVE-2020-10266, CVE-2020-10290 |
| MAVLink v1.0 autopilot or GCS | CVE-2020-10281, CVE-2020-10283 |
| Unitree Go2 running firmware V1.1.7-V1.1.11 EDU | CVE-2026-27509, CVE-2026-27510, and the BLE-side UniPwn class |
| Unitree G1 | Static fleet-wide Blowfish-ECB key; assume the firmware key is public |
| ABB IRC5 with UAS enabled | Default credentials (CVE-2020-10287) |

## Related

- [recon.md](recon.md) - how to fingerprint a target to reach these rows
- [hardening.md](hardening.md) - compensating controls when the version cannot be patched
- [resources.md](resources.md) - the papers behind each disclosure
- [tooling.md](tooling.md) - RVD and the scanners that match these entries
