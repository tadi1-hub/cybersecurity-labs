# SSH Brute-Force Detection and Alerting

## Overview

This project is a small Linux-based security monitoring lab that I built to detect repeated SSH authentication failures from the same source IP.

The main idea was to understand how a security monitoring system can collect logs, identify repeated authentication failures, correlate them by source IP, 
and generate an alert when a defined threshold is reached.

The project started as a simple Bash script and was gradually improved as I tested it and found problems with the detection logic, source-IP handling,
scheduling, and alerting.

---

## Objective

The objective of this project was to build and test a simple detection workflow for possible SSH brute-force activity.

The detection rule I used is:

**5 or more failed SSH authentication attempts from the same source IP within 3 minutes = Possible SSH Brute Force**

The alert is intentionally called "Possible" because repeated authentication failures alone do not prove that an attack is taking place.

---

## Lab Environment

### Attacker
- Kali Linux and Ubuntu Desktop
- SSH client

### Target
- Ubuntu Server
- OpenSSH server
- SSH port: `2222`

### Monitoring / Detection
- `journalctl`
- Bash
- `awk`
- `grep`
- `sort`
- `uniq`
- Cron
- `wall`

---

## Lab Architecture

```text
Kali Linux and Ubuntu Desktop
(Attacker)
     |
     | SSH authentication attempts
     v
Ubuntu Server
(Target)
     |
     v
SSH authentication logs
     |
     v
journalctl
     |
     v
Bash detection script
     |
     |-- Extract source IP
     |-- Count failed authentications
     |-- Apply threshold
     |
     v
Possible SSH Brute Force Alert
     |
     |-- Terminal notification
     |-- Persistent alert log
