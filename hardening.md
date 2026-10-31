# ROS / Robotics Hardening and Defence

The defensive half: what to turn on, what to check, and what to tell an operator
whose robot you just broke into. Everything here maps to a finding from
recon.md or a CVE from cves-and-incidents.md.

## Standards and Frameworks

| Standard / Framework | Scope | Link |
|---|---|---|
| ISO 10218-1/-2 | Industrial robot safety | [ISO 10218](https://www.iso.org/standard/73933.html) |
| ISO/TS 15066 | Collaborative robots (cobots) safety | [ISO 15066](https://www.iso.org/standard/62996.html) |
| IEC 62443 | Industrial automation and control systems security | [IEC 62443](https://www.iec.ch/blog/understanding-iec-62443) |
| NIST SP 800-82 Rev.3 | Guide to OT security, covers robotics | [NIST](https://csrc.nist.gov/pubs/sp/800/82/r3/final) |
| NIST IR 8259 | IoT cybersecurity baseline, applies to robots | [NIST.IR.8259.pdf](https://nvlpubs.nist.gov/nistpubs/ir/2020/NIST.IR.8259.pdf) |
| MITRE ATT&CK for ICS | TTPs applicable to industrial robots | [attack.mitre.org/matrices/ics](https://attack.mitre.org/matrices/ics/) |
| SROS2 / DDS-Security | The native ROS 2 security model | [SROS2](https://github.com/ros2/sros2) |
| Robot Security Framework (RSF) | Methodology for robot security assessments | [github.com/aliasrobotics/RSF](https://github.com/aliasrobotics/RSF) |
| OWASP IoT Top 10 | Applies to robot web and cloud surfaces | [OWASP IoT](https://owasp.org/www-project-internet-of-things/) |
| OWASP MASVS / MSTG | When the robot ships a companion mobile app | [OWASP MASVS](https://mas.owasp.org/MASVS/) |
| ENISA Robotics | EU agency guidance | [ENISA Robotics](https://www.enisa.europa.eu/) |
| REP-2006 | ROS 2 vulnerability disclosure policy | [REP-2006](https://ros.org/reps/rep-2006.html) |

## SROS2 / DDS-Security

DDS-Security plugins (Authentication, Access Control, Cryptographic) give you
PKI-based identity, signed permissions and AES-GCM encryption. ROS 2 exposes
them through SROS2: `ros2 security create_keystore`, `ros2 security create_enclave`
and the governance/permissions XML they consume.

| Document | What it answers |
|---|---|
| [About ROS 2 Security](https://docs.ros.org/en/rolling/Concepts/Intermediate/About-Security.html) | Concept overview of the model |
| [Setting up security tutorial](https://docs.ros.org/en/rolling/Tutorials/Advanced/Security/Introducing-ros2-security.html) | End-to-end SROS2 configuration from scratch |
| [Understanding the security keystore](https://docs.ros.org/en/rolling/Tutorials/Advanced/Security/The-Keystore.html) | What every key file is for |
| [Ensuring security across machines](https://docs.ros.org/en/rolling/Tutorials/Advanced/Security/Security-on-Two.html) | Extending SROS2 to multi-host deployments |
| [Deployment Guidelines](https://docs.ros.org/en/humble/Tutorials/Advanced/Security/Deployment-Guidelines.html) | Production hardening practice |
| [SROS2 example policy files](https://github.com/ros2/sros2/tree/rolling/sros2/test/policies) | `talker_listener.policy.xml`, `add_two_ints.policy.xml`, `minimal_action.policy.xml`; copy and adapt |
| [DDS Security spec (OMG)](https://www.omg.org/spec/DDS-SECURITY/) | The upstream standard SROS2 implements |

### Four SROS2 failures that undo everything

1. **SROS2 disabled in dev and never re-enabled for prod.** The default state of
   a ROS 2 install is an open graph.
2. **Wrong `ROS_DOMAIN_ID`.** A default domain silently merges your robot with
   any other ROS 2 process on the same network.
3. **Missing access control policies.** Authentication without permission files
   still lets a valid enclave publish on anything.
4. **Permissive `governance.xml`.** If every domain is `ALLOW`, keep-alive and
   access control are decorative.

## Hardening Quick Wins

- Disable ROS 1 in production; if unavoidable, air-gap it or allow it over VPN only.
- Enable SROS2 with signed governance and permissions XML.
- Pin a unique, non-default `ROS_DOMAIN_ID` per deployment.
- Disable `rosbridge`, or front it with authentication and TLS.
- Secure boot plus signed firmware; encrypted filesystem on removable media.
- Network segmentation: separate safety, control, perception and cloud VLANs.
- Continuous SBOM scanning ([Syft](https://github.com/anchore/syft) + [Grype](https://github.com/anchore/grype)).
- Subscribe to [ROS Security Vulnerability Disclosures](https://ros.org/reps/rep-2006.html) (REP-2006).

## Defending the AI / Perception Layer

Robots run ML for vision, planning and dialog, so the defence has to cover the
model files and the prompts, not only the network.

| Attack class | Control to check |
|---|---|
| Adversarial examples (physical patches that fool detectors) | Test the deployed detector against patched inputs; use [Adversarial Robustness Toolbox (IBM)](https://github.com/Trusted-AI/adversarial-robustness-toolbox) to measure, then harden |
| Sensor spoofing (laser glare on LiDAR, ultrasonic injection on MEMS, GPS spoofing) | Cross-check redundant sensors; treat a single-sensor belief as untrusted |
| Data poisoning of fleet-learned models | Provenance and review on training data; distrust externally sourced datasets |
| Model integrity tampering (`.onnx`, `.pt`, `.engine`) | Signatures and hashes on disk, verified at load; see the model-integrity step in recon.md |
| Prompt injection on LLM-controlled robots | Treat text and image input as attacker-controlled; do not let a prompt reach an actuator command unchecked |
| Backdoored foundation models | Vet pretrained backbones like any other supply-chain dependency |
| VLA jailbreaking (chained text+image prompts) | Safety filter outside the model, at the action layer, not only in the prompt |

Known-bad baselines worth reading before you trust a vendor claim:
[BashRobot](https://arxiv.org/abs/2407.20242) on embodied LLM jailbreaks and
[RoboPAIR](https://robopair.org/) on LLM-controlled robot jailbreaking.

## Reporting and Disclosure

| Vendor | Channel |
|---|---|
| ROS 2 | [REP-2006](https://ros.org/reps/rep-2006.html); non-vendor bugs can also go via Alias Robotics as CNA |
| ABB | [ABB Cybersecurity](https://www.abb.com/global/en/company/about/cybersecurity) |
| Universal Robots | [Universal Robots support](https://www.universal-robots.com/support/) (search "cybersecurity" / "security advisory") |
| Siemens (robotic cells, ICS) | [Siemens ProductCERT](https://www.siemens.com/global/en/products/services/cert.html) |
| KUKA | [KUKA Customer Portal](https://my.kuka.com/) (no public PSIRT page at time of writing) |
| Fanuc | [fanucamerica.com/contact](https://www.fanucamerica.com/contact) (no public PSIRT page at time of writing) |
| Boston Dynamics | security[at]bostondynamics.com (no public page at time of writing) |

## Related

- [recon.md](recon.md) - the findings these controls close
- [cves-and-incidents.md](cves-and-incidents.md) - what gets exploited when they are missing
- [resources.md](resources.md) - papers and talks behind the standards
- [tooling.md](tooling.md) - SBOM and SROS2 tooling
