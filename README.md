# ctf-ros

An agent skill for **ROS / ROS 2 and robotics security** work: CTF challenges, authorized
pentests, and the defensive side. It is a condensed, actionable rewrite of the curated
[awesome-ros-security](https://github.com/iotsrg/awesome-ros-security) list - every tool, CVE,
paper and link in it is traceable back to that source, but the content is reorganised as
"what to do when you see X" rather than as a link dump.

```
SKILL.md                 entry point: layer router, ROS 1 vs ROS 2, first-move table, env setup
recon.md                 attack surface, recon workflow, six pentest checklists
tooling.md               tools grouped by job, each with a "reach for it when" column
ctf-and-labs.md          robot CTFs, practice labs, simulators, learning hardware
cves-and-incidents.md    CVE catalogue by vendor, published incidents, fingerprint->CVE lookup
hardening.md             SROS2 / DDS-Security, standards, hardening wins, perception defence
resources.md             papers, talks, blogs, books, courses, communities
```

1002 lines, 267 source-verified URLs, 17 CVEs, 15 arXiv papers.

## Install

### Claude Code / DSH style skill directory

```bash
git clone https://github.com/infinitepwn/ctf-ros.git
./ctf-ros/install.sh
```

`install.sh` copies the skill into `${DSH_SKILLS_DIR:-$HOME/.dsh/skills}/ctf-ros`. Override
`DSH_SKILLS_DIR` for any other agent that reads a skills directory:

```bash
DSH_SKILLS_DIR=~/my-agent/skills ./ctf-ros/install.sh
```

### Manual

Copy the directory so that `SKILL.md` sits at the root of a folder named `ctf-ros`:

```
<skills-dir>/ctf-ros/SKILL.md
<skills-dir>/ctf-ros/recon.md
...
```

## How an agent uses it

`SKILL.md` opens with a router table: identify the layer you were handed (live network, PCAP,
firmware image, source package, web dashboard, perception model, drone link, CTF bundle), then
follow the one reference file that matches. The frontmatter follows the common skill convention:

```yaml
name: ctf-ros
description: ...when to use / when NOT to use...
allowed-tools: Bash Read Write Edit Glob Grep Task WebFetch WebSearch Skill
```

Inside, ROS 2 is reached with `ros2 node list` / `ros2 topic echo` after setting
`ROS_DOMAIN_ID` and `RMW_IMPLEMENTATION`; ROS 1 with `ROS_MASTER_URI` and
`rosnode` / `rostopic` / `rosservice` / `rosparam`. Reference files are loaded on demand,
not up front.

## Scope and safety

Everything here is for **your own hardware, an explicitly authorized lab, or a CTF**. A robot is a
cyber-physical system: a wrong message on `/cmd_vel` is not a failed request, it is a moving
machine. Exploit in simulation unless the engagement states that real hardware is in scope and
names a stop condition.

## Verification

- Every URL in this repo (267 unique) also appears in the upstream list; none were invented.
- All 17 CVE identifiers and 15 arXiv identifiers match the upstream text one to one.
- ASCII-only, one H1 per file, sibling links checked, line counts as listed above.
- CVE identifiers are reproduced as upstream publishes them; confirm the ID and affected versions
  against NVD or the vendor advisory before quoting one in a report.

## Attribution and license

Content condensed from [iotsrg/awesome-ros-security](https://github.com/iotsrg/awesome-ros-security),
which builds on the work of [Alias Robotics](https://aliasrobotics.com/) and the
[Robot Vulnerability Database](https://github.com/aliasrobotics/RVD), and on the research, vendor
advisories and conference talks linked inside. The skill layout and frontmatter follow the
conventions of the [ctf-skills](https://github.com/ljagiello/ctf-skills) family by Lukasz Jagiello.

Released under the MIT license (see [LICENSE](LICENSE)). Upstream links remain the property of
their authors; this repo claims no ownership over them.
