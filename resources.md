# ROS / Robotics Security Reading, Talks and Communities

The literature side: papers worth citing, talks worth watching, and the
communities where disclosures land first. Start with
[ROS 2 Documentation home](https://docs.ros.org/) if the ROS concepts are new;
the security-specific subset is in hardening.md.

## Research Papers

### Foundational ROS security

- **[SROS: Securing ROS over the wire, in the graph, and through the kernel](https://arxiv.org/abs/1611.07060)** - White, Christensen, Quigley, 2016
- **[Scanning the Internet for ROS: A View of Security in Robotics Research](https://arxiv.org/abs/1808.03322)** - DeMarinis, Tellex, Kemerlis, Konidaris, Fonseca, 2018
- **[Penetration Testing ROS](https://link.springer.com/chapter/10.1007/978-3-030-20190-6_8)** - Dieber, White, Taurer, Breiling, Caiazza, Christensen, Cortesi, 2019 ([Semantic Scholar mirror](https://www.semanticscholar.org/paper/Penetration-Testing-ROS-Dieber-White/8cba0c235e9444db5d1058abf243e7a7ed3609b7))
- **[Can ROS be Used Securely in Industry? Red-Teaming ROS-Industrial](https://arxiv.org/abs/2009.08211)** - Mayoral-Vilches, Pinzger, Rass, Dieber, Gil-Uriarte, 2020

### ROS 2 / SROS2 / DDS

- **[SROS2: Usable Cyber Security Tools for ROS 2](https://arxiv.org/abs/2208.02615)** - Mayoral-Vilches, White, Caiazza, Arguedas, IROS 2022

### Vulnerability discovery and tooling

- **[Introducing the Robot Vulnerability Database (RVD)](https://arxiv.org/abs/1912.11299)** - Mayoral-Vilches, Usategui San Juan, Dieber, Ayucar Carbajo, Gil-Uriarte, 2019
- **[Robot Vulnerability Scoring System (RVSS)](https://arxiv.org/abs/1807.10357)** - Mayoral-Vilches et al., 2018
- **[DevSecOps in Robotics](https://arxiv.org/abs/2003.10402)** - Mayoral-Vilches, Garcia-Maestro, Towers, Gil-Uriarte, 2020
- **[Robotics CTF (RCTF), a Playground for Robot Hacking](https://arxiv.org/abs/1810.02690)** - Olalde Mendia, Usategui San Juan, Perez Bascaran et al., 2018

### Industrial robot attacks

- **[Rogue Robots: Testing the Limits of an Industrial Robot's Security](https://documents.trendmicro.com/assets/wp/wp-industrial-robot-security.pdf)** - Maggi, Quarta, Pogliani, Polino, Zanchettin, Zanero (Trend Micro and Polimi), 2017 white paper
- **[An Experimental Security Analysis of an Industrial Robot Controller](https://ieeexplore.ieee.org/document/7958582)** - Quarta, Pogliani, Polino, Maggi, Zanchettin, Zanero, IEEE S&P 2017
- **[Detecting Insecure Code Patterns in Industrial Robot Programs](https://dl.acm.org/doi/10.1145/3320269.3384735)** - Pogliani, Maggi, Balduzzi, Quarta, Zanero, AsiaCCS 2020
- **[Rogue Automation: Vulnerable and Malicious Code in Industrial Programming](https://documents.trendmicro.com/assets/white_papers/wp-rogue-automation-vulnerable-and-malicious-code-in-industrial-programming.pdf)** - Maggi et al., Trend Micro and Polimi, 2020 (companion to the OTRazor Black Hat USA 2020 talk)
- **Hacking Robots Before Skynet** - Cerrudo and Apa (IOActive), 2017 ([paper](https://www.ioactive.com/wp-content/uploads/pdfs/Hacking-Robots-Before-Skynet.pdf), [technical appendix](https://www.ioactive.com/wp-content/uploads/pdfs/Hacking-Robots-Before-Skynet-Technical-Appendix.pdf))

### AI / perception / VLA

- **[Adversarial Sensor Attack on LiDAR-based Perception in Autonomous Driving](https://arxiv.org/abs/1907.06826)** - Cao, Xiao, Cyr, Zhou, Park, Rampazzi, Chen, Fu, Mao, ACM CCS 2019
- **[Adversarial Patch](https://arxiv.org/abs/1712.09665)** - Brown, Mane, Roy, Abadi, Gilmer, 2017
- **[NO Need to Worry about Adversarial Examples in Object Detection in Autonomous Vehicles](https://arxiv.org/abs/1707.03501)** - Lu, Sibai, Fabry, Forsyth, 2017 (counter-argument: adversarial examples do not reliably transfer to moving vehicles)
- **[Jailbreaking LLM-Controlled Robots (RoboPAIR)](https://arxiv.org/abs/2410.13691)** - Robey, Ravichandran, Kumar, Hassani, Pappas, 2024
- **[BadRobot: Jailbreaking Embodied LLMs in the Physical World](https://arxiv.org/abs/2407.20242)** - Zhang et al., 2024 (ICLR 2025)
- **[Cybersecurity AI: Humanoid Robots as Attack Vectors](https://arxiv.org/abs/2509.14139)** - Mayoral-Vilches, Makris, Finisterre, 2025 (Unitree G1 case study)

## Conference Talks

### Industrial robot attacks

- **Quarta, Pogliani, Polino, Maggi, Zanchettin, Zanero** - *An Experimental Security Analysis of an Industrial Robot Controller* - IEEE S&P 2017, [paper](https://ieeexplore.ieee.org/document/7958582), [project page](https://robosec.org/)
- **Quarta, Maggi et al.** - *Breaking the Laws of Robotics: Attacking Industrial Robots* - Black Hat USA 2017, [briefing page](https://www.blackhat.com/us-17/briefings/schedule/#breaking-the-laws-of-robotics-attacking-industrial-robots-7256)
- **Maggi, Pogliani et al.** - *OTRazor: Static Code Analysis for Vulnerability Discovery in Industrial Automation Scripts* - Black Hat USA 2020, [white paper](https://i.blackhat.com/USA-20/Wednesday/us-20-Maggi-OTRazor-Static-Code-Analysis-For-Vulnerability-Discovery-In-Industrial-Automation-Scripts-wp.pdf), [speaker page](https://maggi.cc/talk/maggi_otrazorbhus_talk_2020/)
- **Pogliani, Maggi, Balduzzi, Quarta, Zanero** - *Detecting Insecure Code Patterns in Industrial Robot Programs* - AsiaCCS 2020, [paper](https://www.semanticscholar.org/paper/Detecting-Insecure-Code-Patterns-in-Industrial-Pogliani-Maggi/ced923c300b63d043629fd200beac7168e04b765)

### Consumer robots (vacuum, lawn mower, smart home)

- **Giese** - *Reverse Engineering and Hacking Ecovacs Robots* - DEF CON 32 (2024), [slides](https://dontvacuum.me/talks/DEFCON32/DEFCON32_reveng_hacking_ecovacs_robots.pdf), [forum](https://forum.defcon.org/node/245765)
- **Giese** - *Sucking Dust and Cutting Grass: Reversing Robots and Bypassing Security* - 37C3 (2023), [video](https://media.ccc.de/v/37c3-11943-sucking_dust_and_cutting_grass_reversing_robots_and_bypassing_security), [slides and demos](https://dontvacuum.me/talks/37c3-2023/37c3-vacuuming-and-mowing.html)
- **Giese** - *Vacuum Robot Security and Privacy* - DEF CON 31 (2023), [speaker index](https://dontvacuum.me/talks/)
- **Giese and Wegemer** - *Unleash Your Smart-Home Devices: Vacuum Cleaning Robot Hacking* - 34C3 (2017), [video](https://media.ccc.de/v/34c3-9147-unleash_your_smart-home_devices_vacuum_cleaning_robot_hacking), [slides](https://dontvacuum.me/talks/34c3-2017/34c3.html), [YouTube mirror](https://www.youtube.com/watch?v=uhyM-bhzFsI)

### Tools and methodology

- **Cerrudo and Apa (IOActive)** - *Hacking Robots Before Skynet* - HITB GSEC 2017 and Ekoparty 2017, [HITB video](https://www.youtube.com/watch?v=CD2w602tyJk), [Ekoparty video](https://www.youtube.com/watch?v=ki66_wij_Dk)
- **Mayoral-Vilches et al.** - *SROS2: Usable Cyber Security Tools for ROS 2* - 2022, [paper](https://arxiv.org/abs/2208.02615), [slides](https://aliasrobotics.com/files/SROS2.pdf)
- **ROS-SWG** - *ROS 2 Security Workshop* - ROSCon 2019, [workshop site with slides and exercises](https://ros-swg.github.io/ROSCon19_Security_Workshop/)
- **McClean, Stull, Farrar, Mascarenas** - *A Preliminary Cyber-Physical Security Assessment of the Robot Operating System (ROS)* - SPIE 2013 (DEF CON 20 honeypot project), [paper](https://ui.adsabs.harvard.edu/abs/2013SPIE.8741E..10M/abstract)

### LiDAR and perception

- **Cao et al.** - *You Can't See Me: Physical Removal Attacks on LiDAR-based Autonomous Vehicles* - USENIX Security 2023, [paper](https://www.usenix.org/system/files/sec23summer_349-cao-prepub.pdf), [talk page](https://www.usenix.org/conference/usenixsecurity23/presentation/cao)
- **Sun, Cao, Chen, Mao** - *Towards Robust LiDAR-based Perception in Autonomous Driving: Black-box Adversarial Sensor Attack* - USENIX Security 2020, [USENIX page](https://www.usenix.org/conference/usenixsecurity20/presentation/sun), [PDF](https://ics.uci.edu/~alfchen/jiachen_usenix20.pdf)

### LLM-controlled robots

- **Robey, Ravichandran, Kumar, Hassani, Pappas** - *Jailbreaking LLM-Controlled Robots* (RoboPAIR) - UPenn / CMU 2024, [project](https://robopair.org/), [CMU ML blog writeup](https://blog.ml.cmu.edu/2024/10/29/jailbreaking-llm-controlled-robots/)
- **Mayoral-Vilches et al.** - *Cybersecurity AI: Humanoid Robots as Attack Vectors* (Unitree G1) - 2025, [paper](https://arxiv.org/html/2509.14139v1)

### Archives to search when nothing above matches

[DEF CON Media Server](https://media.defcon.org/), [DEF CON YouTube](https://www.youtube.com/user/DEFCONConference),
[Black Hat archives](https://www.blackhat.com/html/archives.html),
[ROSCon talk index](https://roscon.ros.org/), [CCC media](https://media.ccc.de/),
[USENIX Security programs](https://www.usenix.org/conferences/byname/108),
[NDSS Symposium](https://www.ndss-symposium.org/),
[IEEE S&P past programs](https://www.ieee-security.org/TC/SP-Index.html),
[ACM CCS proceedings](https://www.sigsac.org/ccs.html),
[HITB archive](https://conference.hitb.org/), [Don't Vacuum Me talk index](https://dontvacuum.me/talks/),
[RoboSec](https://robosec.org/).

## Blogs and Vendor Research

### Robotics-focused security teams

[Alias Robotics blog](https://news.aliasrobotics.com/) (the most consistent robotics
security output), [Trend Micro Research](https://www.trendmicro.com/vinfo/us/security/research-and-analysis/research),
[IOActive Labs](https://labs.ioactive.com/), [NCC Group Research](https://research.nccgroup.com/),
[Bishop Fox Labs](https://bishopfox.com/blog), [Trail of Bits](https://blog.trailofbits.com/),
[Cybereason Nocturnus](https://www.cybereason.com/blog).

### ICS / OT research that covers robots

[Claroty Team82](https://claroty.com/team82), [Forescout Research (Vedere Labs)](https://www.forescout.com/blog/),
[Dragos](https://www.dragos.com/blog/), [Kaspersky ICS-CERT](https://ics-cert.kaspersky.com/),
[Nozomi Networks Labs](https://www.nozominetworks.com/blog/),
[Microsoft Defender for IoT](https://www.microsoft.com/en-us/security/blog/topic/iot-security/),
[Cisco Talos](https://blog.talosintelligence.com/).

### Community blogs

[ROS Discourse](https://discourse.openrobotics.org/) (search "security"; threads are
tagged, there is no longer a dedicated category), [Robohub](https://robohub.org/),
[The Construct](https://www.theconstructsim.com/), [Fort Robotics](https://www.fortrobotics.com/news),
[Robotic Industries Association](https://www.automate.org/blogs).

## Newsletters and Podcasts

**Newsletters:** [Alias Robotics newsletter](https://news.aliasrobotics.com/),
[SANS NewsBites](https://www.sans.org/newsletters/newsbites/),
[Dragos WorldView Threat Intelligence](https://www.dragos.com/threat-intelligence/),
[N2K Networks CyberWire](https://thecyberwire.com/podcasts).

**Podcasts:** [Robohub Podcast](https://robohub.org/podcast/),
[Unsolicited Response (Dale Peterson)](https://dale-peterson.com/podcast/),
[Hack the Plant (Bryson Bort, ICS Village)](https://icsvillage.com/podcast),
[Darknet Diaries](https://darknetdiaries.com/),
[Risky Business](https://risky.biz/netcasts/risky-business/).

## Books

### ROS foundations (before security)

- **[Programming Robots with ROS](https://www.oreilly.com/library/view/programming-robots-with/9781449325480/)** - Morgan Quigley, Brian Gerkey, William D. Smart, O'Reilly 2015. ROS 1 only, but the architecture chapters are still the best in print. [Sample code](https://github.com/gbiggs/ros_book_sample_code).
- **[Mastering ROS 2 for Robotics Programming, 4th ed.](https://www.packtpub.com/en-us/product/mastering-ros-2-for-robotics-programming-9781836209010)** - Lentin Joseph, Jonathan Cacace, Packt 2024. ROS 2 Jazzy, Nav2, MoveIt 2, Gazebo Sim, Micro-ROS. [Source code](https://github.com/PacktPublishing/Mastering-ROS-2-for-Robotics-Programming).
- **[A Concise Introduction to Robot Programming with ROS 2 (2nd ed.)](https://www.routledge.com/A-Concise-Introduction-to-Robot-Programming-with-ROS-2/Rico/p/book/9781032851488)** - Francisco Martin Rico. [Companion code](https://github.com/fmrico/book_ros2).

### Theory

- **[Modern Robotics: Mechanics, Planning, and Control](http://hades.mech.northwestern.edu/index.php/Modern_Robotics)** - Kevin Lynch and Frank Park, Cambridge University Press 2017; free PDF on the Northwestern wiki.

### Adjacent, security-relevant

- **Industrial Cybersecurity (2nd ed.)** - Pascal Ackerman, Packt 2021. OT context for industrial robots.
- **The Car Hacker's Handbook** - Craig Smith, No Starch 2016. CAN bus work overlaps with robot controllers.
- **Practical IoT Hacking** - Fotios Chantzis, Ioannis Stais, Paulino Calderon, Evangelos Deirmentzoglou, Beau Woods, No Starch 2021.
- **The Hardware Hacker** - Andrew "bunnie" Huang, No Starch 2017. For when you have physical access.

## Courses and Training

### ROS fundamentals

- **[The Construct, ROS 2 Basics](https://www.theconstruct.ai/robotigniteacademy_learnros/ros-courses-library/ros2-basics-course/)** - in-browser ROS 2, no local setup, free and paid tiers.
- **[Coursera, Modern Robotics specialization (Northwestern)](https://www.coursera.org/specializations/modernrobotics)** - six-course series by Lynch and Park.
- **[ROS-Industrial training (ROS 1)](https://industrial-training-master.readthedocs.io/)** - the canonical industrial training material; lab base in ctf-and-labs.md.
- **[ROS-Industrial ROS 2 training](https://github.com/ros-industrial/ros2_i_training)** - the ROS 2 (Foxy onward) equivalent.

### Security-specific

- **[The Construct, ROS 2 Security Online Course](https://www.theconstruct.ai/robotigniteacademy_learnros/ros-courses-library/ros2-security-online-course/)** - one of the very few dedicated ROS 2 security courses.
- **[Cybersecurity for Robotics, Alias Robotics](https://aliasrobotics.com/training.php)** - vendor-run, hands-on with their Alurity toolbox.
- **[SANS ICS410, ICS/SCADA Security Essentials](https://www.sans.org/cyber-security-courses/ics-scada-cyber-security-essentials/)** - ICS context, not robot-specific.
- **[SANS ICS612, ICS Cybersecurity In-Depth](https://www.sans.org/cyber-security-courses/ics-cybersecurity-in-depth/)** - deeper OT.

## Video Series

- **[Articulated Robotics (Josh Newans)](https://www.youtube.com/@ArticulatedRobotics/videos)** - "Build a real robot with ROS 2"; companion site [articulatedrobotics.xyz](https://articulatedrobotics.xyz/).
- **[The Construct on YouTube](https://www.youtube.com/@TheConstruct)** - ROS 1 and ROS 2 walkthroughs, open classes.
- **[ROBOTIS e-Manual videos](https://emanual.robotis.com/docs/en/platform/turtlebot3/videos/)** - TurtleBot3 reference videos.
- **[ROSCon recordings (Vimeo)](https://vimeo.com/osrfoundation)** - the OSRF archive of ROSCon and OSRF talks.
- **[LiveOverflow](https://www.youtube.com/@LiveOverflow)**, **[stacksmashing](https://www.youtube.com/@stacksmashing)**, **[Hak5](https://www.youtube.com/@hak5)** - embedded and hardware security that transfers directly to robot internals.

## Communities and Disclosure

- **[ROS 2 Security Working Group](https://github.com/ros-security/community)** - official WG: meeting notes, agendas.
- **[ROS Deliberation WG](https://github.com/ros-wg-delib)** - task planning and autonomy stack, security-adjacent.
- **[Alias Robotics](https://aliasrobotics.com/)** - CNA for robot CVEs, runs RVD.
- **[IOTSRG](https://iotsrg.org/)** - the IoT Security Research Group, home of the source list.
- **[ROS Discourse](https://discourse.openrobotics.org/)** - search "security" or "SROS2".
- **[ICS-CERT / CISA](https://www.cisa.gov/topics/industrial-control-systems)** - industrial robot advisories.
- **[NVD](https://nvd.nist.gov/)**, **[CVE.org](https://www.cve.org/)** - the registries behind every entry in cves-and-incidents.md.

Report ROS bugs via [REP-2006](https://ros.org/reps/rep-2006.html); report vendor
robots via the vendor PSIRT or Alias Robotics as CNA. The full channel table is in
hardening.md.

## Related Curated Lists and Consortia

- **[fkromer/awesome-ros2](https://github.com/fkromer/awesome-ros2)** - largest curated ROS 2 list (archived 2024, still excellent reference).
- **[ps-micro/awesome-ros](https://github.com/ps-micro/awesome-ros)** - ROS 1 curated list.
- **[ahundt/awesome-robotics](https://github.com/ahundt/awesome-robotics)**, **[kiloreux/awesome-robotics](https://github.com/kiloreux/awesome-robotics)**, **[jslee02/awesome-robotics-libraries](http://jslee02.github.io/awesome-robotics-libraries/)** - general robotics and library lists.
- **[shannon112/awesome-ros-mobile-robot](https://github.com/shannon112/awesome-ros-mobile-robot)** - SLAM, odometry, navigation.
- **[Guillaumebeuzeboc/awesome-ROS-snap](https://github.com/Guillaumebeuzeboc/awesome-ROS-snap)** - ROS as Snap packages.
- **[Awesome ICS Security guide](https://github.com/V33RU/awesome-connected-things-sec/blob/main/docs/ICS/Industrial-Control-Systems.md)** - the OT pivot reading.
- **[ROS-Industrial](https://rosindustrial.org/)**, **[ROS-Industrial GitHub org](https://github.com/ros-industrial)**, plus the regional consortia: [Americas (SwRI)](https://rosindustrial.org/ric-americas), [Europe (Fraunhofer IPA)](https://rosin-project.eu/), [Asia Pacific (ARTC, Singapore)](https://rosindustrial.org/ric-apac).

## Related

- [recon.md](recon.md) - the practical counterpart to these papers
- [hardening.md](hardening.md) - the standards and the security docs
- [cves-and-incidents.md](cves-and-incidents.md) - the disclosures these papers describe
- [ctf-and-labs.md](ctf-and-labs.md) - environments to practice in
