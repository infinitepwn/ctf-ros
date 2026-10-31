# ROS / Robotics CTFs, Labs, Simulators and Learning Hardware

Everything here is for authorized labs, CTF scenarios, and owned hardware. A
simulator is the correct place to learn topic poisoning and node spoofing;
production robots are not a lab.

## CTFs and Practice Labs

| Resource | Use it for | Link |
|---|---|---|
| Robotics CTF (RCTF) | Dedicated robot-hacking challenges (archived 2020, but the scenarios are still useful) | [github.com/aliasrobotics/RCTF](https://github.com/aliasrobotics/RCTF) |
| Alurity | Modular toolbox for spinning up robot cyber lab scenarios | [aliasrobotics.com/alurity.php](https://aliasrobotics.com/alurity.php) |
| ROS-Industrial Training repo | A working ROS base to wire offensive scenarios on top of | [github.com/ros-industrial/industrial_training](https://github.com/ros-industrial/industrial_training) |
| Gazebo Sim | Build your own red-team scenarios safely | [gazebosim.org](https://gazebosim.org/) |
| Foxglove Studio | Live visualization while debugging an attack against a running graph | [foxglove.dev](https://foxglove.dev/) |
| CTFtime ICS/SCADA tag | Finding robot-themed CTFs when they run | [ctftime.org/tag/ics](https://ctftime.org/tag/ics/) |

Foxglove wires to a robot over its own [WebSocket protocol spec](https://github.com/foxglove/ws-protocol),
which also makes it a convenient front end for replaying captured traffic.

## Simulators and Lab Environments

| Environment | Notes | Link |
|---|---|---|
| Gazebo Sim | The standard ROS 2 simulator; scenario source for most labs | [gazebosim.org](https://gazebosim.org/) / [github.com/gazebosim/gz-sim](https://github.com/gazebosim/gz-sim) |
| Ignition / Gazebo Fortress | The LTS Gazebo pairing for ROS 2 Humble | [gazebosim.org/docs/fortress](https://gazebosim.org/docs/fortress/) |
| Webots | Open-source, cross-platform robot simulator | [cyberbotics.com](https://cyberbotics.com/) |
| Isaac Sim (NVIDIA) | GPU-accelerated photorealistic simulator with a ROS 2 bridge | [developer.nvidia.com/isaac/sim](https://developer.nvidia.com/isaac/sim) |
| Alurity | Dockerized robot-cybersecurity toolbox from Alias Robotics | [aliasrobotics.com/alurity.php](https://aliasrobotics.com/alurity.php) |
| ROSCon19 Security Workshop | Reproducible SROS2 lab with slides and exercises | [ros-swg.github.io/ROSCon19_Security_Workshop](https://ros-swg.github.io/ROSCon19_Security_Workshop/) |

Use the simulators to practice the probes in recon.md without bricking
hardware, and the security workshop when you specifically need SROS2 working
end to end before you test a deployment that claims to run it.

## Learning Hardware

The platforms that show up in most papers, tutorials, and CTFs.

| Platform | Why it is on this list | Link |
|---|---|---|
| TurtleBot3 (ROBOTIS) | The de-facto ROS / ROS 2 learning robot; cheap and supports SROS2 demos | [emanual.robotis.com](https://emanual.robotis.com/docs/en/platform/turtlebot3/overview/) |
| TurtleBot 4 (Clearpath / iRobot Create 3) | ROS 2 native successor to the TurtleBot3 | [turtlebot.github.io](https://turtlebot.github.io/turtlebot4-user-manual/) |
| Clearpath Husky / Jackal | Outdoor and heavy unmanned ground vehicles, common in academic security research | [clearpathrobotics.com](https://clearpathrobotics.com/) |
| Universal Robots UR3e/UR5e/UR10e | The cobot platform behind most published industrial-robot CVEs | [universal-robots.com](https://www.universal-robots.com/) |
| Unitree Go2 / G1 | Quadruped and humanoid; subject of recent LLM-jailbreak research | [unitree.com](https://www.unitree.com/) |

## Building a Lab, In Order

1. **Install a ROS 2 distro and Gazebo Sim.** Bring up any stock simulation so
   you have nodes, topics, and a graph to look at.
2. **Learn the graph blind.** Enumerate a running simulation with
   `ros2 node list`, `ros2 topic list`, and `ros2 topic echo` until the
   layout is obvious before you attack it.
3. **Run the ROSCon19 security workshop.** It gives you a keystore, enclaves,
   and a working SROS2 policy to break; without it, SROS2 findings stay theoretical.
4. **Bring up a TurtleBot3 in the simulator.** It is the smallest robot that
   exercises mobile-base topics such as `/cmd_vel`, which is where the
   actuation findings in recon.md live.
5. **Add Alurity.** Once you have a graph, Alurity gives you the packaged
   attack tooling instead of hand-rolled scripts.
6. **Point Foxglove Studio at it.** Being able to see the robot state change as
   your payload lands is the difference between a script that ran and a finding.
7. **Only then move to real hardware**, and only hardware you own: the
   TurtleBot3 is the cheapest safe step up from the simulator.

## Practice Targets by Skill

| Skill you want | Environment |
|---|---|
| ROS 1 master abuse, XML-RPC | ROS 1 tutorial stack on an isolated network (roschaos / ROSPenTo targets) |
| ROS 2 graph enumeration, DDS | Gazebo Sim + any ROS 2 demo nodes |
| SROS2 policy work | ROSCon19 Security Workshop keystore |
| Actuation impact | TurtleBot3 in Gazebo, then a physical TurtleBot3 |
| Industrial cell reasoning | ROS-Industrial training material plus industrial robot specifics in cves-and-incidents.md |
| Firmware and hardware | Any of the learning robots you own, opened up; see tooling.md hardware section |

## What to Capture in a Lab Run

- The topic and node names you touched, so a fix can be verified later.
- The exact tool version, because ROS 2 distro bugs are version-specific
  (see cves-and-incidents.md).
- Whether SROS2 was on for the run: most "no auth" results disappear the moment
  security is enabled, and reporting them otherwise is noise.

## Where the Challenges Are Announced

- [CTFtime ICS/SCADA tag](https://ctftime.org/tag/ics/) for robot-themed events.
- [ROS Discourse](https://discourse.openrobotics.org/) for workshop and course announcements.
- [ROS 2 Security Working Group](https://github.com/ros-security/community) for security exercises and meeting notes.

## Related

- [recon.md](recon.md) - the probes to practice here
- [tooling.md](tooling.md) - tools to install into the lab
- [cves-and-incidents.md](cves-and-incidents.md) - incidents to reproduce deliberately
- [resources.md](resources.md) - papers and courses that go with the labs
