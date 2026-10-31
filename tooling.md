# ROS / Robotics Security Tooling

Grouped by the job you are doing, not by vendor. Every tool below is the one
named in the source list; the "Reach for it when" column is the decision point.

## ROS / ROS 2 Specific

| Tool | Reach for it when | Link |
|---|---|---|
| ROSPenTo | You have a reachable ROS 1 master and need XML-RPC-level enumeration and graph manipulation | [github.com/jr-robotics/ROSPenTo](https://github.com/jr-robotics/ROSPenTo) |
| ROSploit | Two-phase recon then exploit run against ROS 1 | [github.com/seanrivera/rosploit](https://github.com/seanrivera/rosploit) |
| roschaos | You want fault injection / chaos engineering across the ROS graph instead of an exploit | [github.com/ruffsl/roschaos](https://github.com/ruffsl/roschaos) |
| Robosploit (Alurity) | Robotics exploitation framework by Alias Robotics; also the lab toolbox | [aliasrobotics.com/alurity.php](https://aliasrobotics.com/alurity.php) |
| HAROS | Static analysis of a ROS C++/Python codebase before you touch the live graph | [github.com/git-afsantos/haros](https://github.com/git-afsantos/haros) |
| aztarna | Footprinting ROS, SROS and industrial routers (archived 2020, but still useful) | [github.com/aliasrobotics/aztarna](https://github.com/aliasrobotics/aztarna) |
| RVD | You need the robot flaw registry and its CLI | [github.com/aliasrobotics/RVD](https://github.com/aliasrobotics/RVD) |
| RSF (Robot Security Framework) | You need an assessment methodology, not a single tool | [github.com/aliasrobotics/RSF](https://github.com/aliasrobotics/RSF) |
| SROS2 CLI | Generating keystores, enclaves, governance/permissions XML | [github.com/ros2/sros2](https://github.com/ros2/sros2) |
| dds-perftest / shapes_demo | DDS reference apps used to validate isolation between domains | [Fast-DDS docs](https://fast-dds.docs.eprosima.com/) |

```bash
ros2 security create_keystore
ros2 security create_enclave
```

The SROS2 CLI surface for policy work. The docs linked in hardening.md give the
argument forms; do not guess them on a live keystore.

## Drone / UAV

| Tool | Reach for it when | Link |
|---|---|---|
| dronesploit | Drone pentest framework covering Wi-Fi and MAVLink | [github.com/dronesploit/dronesploit](https://github.com/dronesploit/dronesploit) |
| MAVProxy | You need a MAVLink ground station to drive or fuzz an autopilot | [github.com/ArduPilot/MAVProxy](https://github.com/ArduPilot/MAVProxy) |
| pymavlink | Crafting MAVLink packets in Python | [github.com/ArduPilot/pymavlink](https://github.com/ArduPilot/pymavlink) |
| MAVLink-Router | Routing proxy useful for MAVLink MITM | [github.com/mavlink-router/mavlink-router](https://github.com/mavlink-router/mavlink-router) |
| Skyjack | Reference PoC for Parrot AR.Drone hijacking (classic, historical) | [samy.pl/skyjack](https://samy.pl/skyjack/) |
| Aircrack-ng | Drone Wi-Fi de-auth and WPA capture | [aircrack-ng.org](https://www.aircrack-ng.org/) |
| GNU Radio | SDR baseband work for drone telemetry capture | [gnuradio.org](https://www.gnuradio.org/) |

## Exploitation Frameworks

- [Metasploit Framework](https://github.com/rapid7/metasploit-framework): general framework; a few ICS/robot modules.
- [ISF, Industrial Security Exploitation Framework](https://github.com/dark-lbp/isf): ICS/robotics modules.
- [RouterSploit](https://github.com/threat9/routersploit): embedded device exploits, useful against robot controllers.
- [w3af](https://github.com/andresriancho/w3af): for robot web dashboards.
- [expliot](https://gitlab.com/expliot_framework/expliot): IoT / robotics pentest framework (BLE, MQTT, Modbus, CoAP).
- [Cotopaxi](https://github.com/Samsung/cotopaxi): Samsung IoT/robot protocol fuzzer and tester.

## Network, DDS and Protocol Analysis

| Tool | Reach for it when | Link |
|---|---|---|
| Nmap | Service discovery; ports 11311 (ROS 1), 7400-7500 (DDS RTPS) | [nmap.org](https://nmap.org/) |
| Masscan | High-speed scanning across a robot fleet | [github.com/robertdavidgraham/masscan](https://github.com/robertdavidgraham/masscan) |
| Wireshark + RTPS dissector | Reading DDS traffic off the wire | [RTPS dissector](https://wiki.wireshark.org/Protocols/rtps) |
| Scapy | Packet crafting for RTPS / TCPROS | [scapy.net](https://scapy.net/) |
| SSLyze | Robot HTTPS endpoints and TLS configuration | [github.com/nabla-c0d3/sslyze](https://github.com/nabla-c0d3/sslyze) |
| fast-dds-discovery-server | DDS discovery analysis | [Fast-DDS docs](https://fast-dds.docs.eprosima.com/en/latest/) |
| fast-dds-monitor | DDS network observability during a test | [github.com/eProsima/Fast-DDS-monitor](https://github.com/eProsima/Fast-DDS-monitor) |
| RTI Connext Admin Console | Introspection on RTI Connext DDS deployments | [rti.com/products/tools](https://www.rti.com/products/tools) |
| Bettercap | MITM on robot Wi-Fi / Ethernet | [github.com/bettercap/bettercap](https://github.com/bettercap/bettercap) |
| mitmproxy | Intercepting robot HTTPS / WebSocket / REST | [mitmproxy.org](https://mitmproxy.org/) |
| zmap + zgrab2 | Finding internet-exposed ROS endpoints at scale | [github.com/zmap/zgrab2](https://github.com/zmap/zgrab2) |

## Hardware

- [Bus Pirate](http://dangerousprototypes.com/docs/Bus_Pirate), [JTAGulator](http://www.grandideastudio.com/jtagulator/), [Saleae](https://www.saleae.com/): physical bus probing.
- [ChipWhisperer](https://www.newae.com/chipwhisperer): side-channel and glitching of robot MCUs.
- [Glasgow Interface Explorer](https://github.com/GlasgowEmbedded/glasgow): multi-protocol hardware tool.
- [CANalyse](https://github.com/KartheekLade/CANalyse) / [caringcaribou](https://github.com/CaringCaribou/caringcaribou): CAN/CANopen on industrial arms.
- [python-can](https://github.com/hardbyte/python-can): CAN scripting; works with SocketCAN, USB2CAN.
- [CANToolz](https://github.com/eik00d/CANToolz): framework for CAN bus auditing.
- [Flipper Zero](https://flipperzero.one/): RF / sub-GHz work on tele-op links.
- [HackRF One](https://greatscottgadgets.com/hackrf/), [RTL-SDR](https://www.rtl-sdr.com/), [LimeSDR](https://limemicro.com/products/boards/limesdr/): SDR for drone/robot telemetry.
- [Proxmark3](https://github.com/RfidResearchGroup/proxmark3): RFID/NFC on robot access cards.
- [FlashROM](https://flashrom.org/) + [CH341A](https://github.com/setarcos/ch341prog): SPI flash dump of robot controllers.

## Static Analysis and SBOM

- [Flawfinder](https://dwheeler.com/flawfinder/), [RATS](https://github.com/andrew-d/rough-auditing-tool-for-security), [Cppcheck](http://cppcheck.sourceforge.net/): C/C++ source scanners.
- [SonarQube](https://www.sonarqube.org/), [Semgrep](https://semgrep.dev/), [CodeQL](https://codeql.github.com/): SAST.
- [OWASP Dependency-Check](https://owasp.org/www-project-dependency-check/), [Syft + Grype](https://github.com/anchore/grype): SBOM and CVE matching for ROS dependencies.
- [clang-tidy](https://clang.llvm.org/extra/clang-tidy/) with the ros-industrial config: enforce safer C++ in ROS nodes.
- [Bandit](https://github.com/PyCQA/bandit): Python SAST for ROS Python nodes.
- [Snyk](https://snyk.io/): SCA over rosdep / pip / apt dependencies.
- [Trivy](https://github.com/aquasecurity/trivy): container scan for ROS Docker images.

## Fuzzing

- [AFL++](https://github.com/AFLplusplus/AFLplusplus), [libFuzzer](https://llvm.org/docs/LibFuzzer.html): message parser fuzzing.
- [Boofuzz](https://github.com/jtpereyda/boofuzz): protocol fuzzing for ROS messages and DDS RTPS.
- [radamsa](https://gitlab.com/akihe/radamsa): general fuzz mutation engine.
- [Honggfuzz](https://github.com/google/honggfuzz): coverage-guided fuzzing.
- [Google Sanitizers](https://github.com/google/sanitizers): ASan/UBSan/TSan on ROS nodes.

## Forensics and Incident Response

- [Volatility 3](https://github.com/volatilityfoundation/volatility3): memory forensics on robot Linux dumps.
- [Autopsy](https://www.autopsy.com/): disk forensics on robot SD cards / eMMC images.
- [bulk_extractor](https://github.com/simsong/bulk_extractor): artifact extraction from raw images.
- [Plaso / log2timeline](https://github.com/log2timeline/plaso): timeline analysis on the robot OS.
- [GRR Rapid Response](https://github.com/google/grr): live IR across a fleet.
- [Velociraptor](https://docs.velociraptor.app/): endpoint visibility that scales to many robots.

## Wireshark Dissectors and Capture

- [RTPS (DDS) dissector](https://wiki.wireshark.org/Protocols/rtps): built into Wireshark.
- [Modbus, EtherCAT, Profinet dissectors](https://www.wireshark.org/docs/dfref/): industrial fieldbuses.
- [rosbag2](https://github.com/ros2/rosbag2): capture ROS 2 traffic to disk for offline analysis.

## Related

- [recon.md](recon.md) - where each tool fits in the workflow
- [ctf-and-labs.md](ctf-and-labs.md) - environments to run them in
- [hardening.md](hardening.md) - SROS2 work the SROS2 CLI supports
