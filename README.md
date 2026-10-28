# Cybersecurity Labs Portfolio

## Overview

Welcome to my cybersecurity labs portfolio. This repository documents my hands-on learning, technical experiments, and practical projects as I build skills toward **Security Operations (SOC), Security Analysis, Incident Response, and Digital Forensics and Incident Response (DFIR)**.

My projects focus on applying cybersecurity concepts in controlled lab environments, investigating technical evidence, testing security controls, documenting findings, and identifying areas for improvement.

## Objectives

- Develop practical skills in security monitoring and log analysis.
- Improve Linux, networking, and security troubleshooting capabilities.
- Practice identifying suspicious activity and investigating its technical evidence.
- Understand defensive security controls and incident response workflows.
- Build clear, evidence-based technical reports for professional development.

## Labs and Projects

### 01 — SSH Brute-Force Detection, Alerting, and Firewall Response

**Focus:** Linux security monitoring, SSH authentication logs, alerting, network investigation, and firewall troubleshooting.

In this lab, I developed a Bash-based detection script to identify repeated failed SSH login attempts from individual source IP addresses. I configured scheduled execution and alert logging, tested detection using multiple sources, and used `tcpdump` and UFW to investigate network traffic and firewall behavior.

**Key technologies:** Bash, Linux, Ubuntu Server, Ubuntu Desktop, Kali Linux, OpenSSH, `journalctl`, cron, `tcpdump`, and UFW.

- [Explore the lab and its evidence](01-ssh-brute-force-detection/README.md)
- [Read the technical report](01-ssh-brute-force-detection/report/SSH_Brute_Force_Detection_Alerting_and_Firewall_Response_Report.pdf)
- [View the detection script](01-ssh-brute-force-detection/scripts/alert.sh)

## Approach to Lab Documentation

Each project aims to document, where applicable:

1. **Objective and scope** — what the lab is intended to investigate.
2. **Environment and tools** — the systems, configurations, and technologies used.
3. **Implementation** — the detection logic, commands, or security controls applied.
4. **Testing and evidence** — the procedures performed and results observed.
5. **Analysis and troubleshooting** — how findings were interpreted and unexpected behavior investigated.
6. **Limitations and improvements** — what the results establish and what could be improved in future iterations.

I distinguish between completed work, observed evidence, and proposed improvements to keep the documentation accurate and reproducible.

## Learning Roadmap

My current development priorities include:

- Linux security monitoring and authentication-log analysis.
- Network traffic analysis and investigation.
- Detection engineering and alert validation.
- Incident investigation and evidence correlation.
- Digital forensics, threat hunting, and cyber threat intelligence.

Future projects will expand on these areas as my practical experience grows.

## Repository Structure

cybersecurity-labs/
├── README.md
└── 01-ssh-brute-force-detection/
    ├── README.md
    ├── evidence/
    ├── log/
    ├── report/
    ├── scripts/
    └── videos/
    
*Additional labs and supporting materials will be added as the portfolio develops.*

## About This Portfolio

This is an ongoing personal learning portfolio created to demonstrate practical cybersecurity skills, technical problem-solving, and evidence-based documentation.

I welcome constructive feedback, technical suggestions, and opportunities to learn from the cybersecurity community.

**GitHub:** [tadi1-hub](https://github.com/tadi1-hub)

**Repository:** [cybersecurity-labs](https://github.com/tadi1-hub/cybersecurity-labs)

