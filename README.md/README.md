# SSH Brute-Force Detection and Alerting

## Overview

This project is a small Linux-based security monitoring lab that I built to detect repeated SSH authentication failures from the same source IP.

The main idea was to understand how a security monitoring system can collect logs, identify repeated authentication failures, correlate them by source IP, and generate an alert when a defined threshold is reached.

The project started as a simple Bash script and was gradually improved as I tested it and found problems with the detection logic, source-IP handling, scheduling, and alerting.

---

## Objective

The objective of this project was to build and test a simple detection workflow for possible SSH brute-force activity.

The detection rule I used is:

> **5 or more failed SSH authentication attempts from the same source IP within 3 minutes = Possible SSH Brute Force**

The alert is intentionally called "Possible" because repeated authentication failures alone do not prove that an attack is taking place.

---

## Lab Environment

### Attacker
- Kali Linux
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
Kali Linux
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

How the Detection Works

The script looks at recent SSH logs and searches for failed password authentication events.

First, I extract the source IP from the failed authentication entries.

Then I group the events by source IP and count how many failures came from each IP.

The detection logic is:

Failed SSH authentication
        ↓
Extract source IP
        ↓
Group by source IP
        ↓
Count attempts
        ↓
If count >= 5 within 3 minutes
        ↓
Generate alert
Detection Command

The main log-processing pipeline is based on:

journalctl --since "3 minutes ago" --unit ssh --no-pager |
grep "Failed password" |
awk '{print $11}' |
sort |
uniq -c

The result is then filtered so that only source IPs reaching the threshold are reported.

Alert

When the threshold is reached, the script generates an alert similar to:

🚨 CRITICAL SECURITY THREAT
Possible SSH Brute Force
Source IP: 192.168.x.x
Number of Attempts: 6
Time Window: 3 minutes
Detected: [timestamp]

The alert is displayed on the terminal using wall and is also written to an alert log for later investigation.

Testing

I tested the detection by generating repeated failed SSH authentication attempts from the Kali machine against the Ubuntu server.

During testing, I initially expected every SSH interaction to appear as a Failed password event. After examining the complete SSH journal, I found that some connections were logged differently, for example:

Connection closed by authenticating user ...

This helped me understand that an SSH connection event is not necessarily the same as a failed password authentication event.

For this reason, the detector specifically uses Failed password entries rather than simply counting every SSH event.

Automated Execution

I initially tested the detection manually.

After the detection logic was working, I added Cron to execute the script automatically.

Current Cron schedule:

* * * * * /usr/local/bin/alert.sh

The script checks the recent detection window each time it runs.

This is scheduled polling rather than a fully event-driven monitoring system.

Evidence
Screenshots

The repository contains screenshots showing:

SSH attack attempts from Kali
Failed authentication events on Ubuntu
Source-IP correlation
Detection script
Generated security alert
Alert log
Response/testing
Video Demonstration

A short videoes demonstrate the active alert being generated during the SSH brute-force test.

The video is located in:

video/
└── possible ssh brute force 1 and 2.mp4
Response

After detecting the repeated authentication failures, I tested firewall-based response using UFW.

Example:

sudo ufw reject in on 2222 from <SOURCE_IP>

This was performed as part of the lab to understand the relationship between detection and response.

What I Learned

This project helped me understand several things that are difficult to learn from theory alone:

How SSH authentication failures appear in Linux logs
How to extract useful information from log entries
How to correlate events by source IP
How threshold-based detection works
The difference between an SSH connection event and an authentication failure
How Bash can be used for basic security monitoring
How Cron can automate a detection script
How alerts can be persisted for later investigation
The difference between scheduled polling and real-time monitoring
Why detection logic needs to be tested against actual logs
Limitations

This is a learning project and is not intended to replace a production SIEM or IDS.

Current limitations include:

Detection depends on the SSH log format.
The script uses scheduled polling through Cron.
Detection latency depends on the Cron interval.
The threshold is manually defined.
There is no alert deduplication yet.
There is no centralized log collection.
There is no dashboard or historical event analysis.
Future Improvements

Possible improvements include:

Event-driven log monitoring
Alert deduplication
Better IP parsing
Multiple detection rules
Centralized logging
Integration with Wazuh or another SIEM
Email or other notification methods
Automated response with safer controls
More detailed incident reporting
Conclusion

This project started as a simple Bash script for counting SSH failures.

While testing it, I found several issues with the initial approach and changed the detection logic to correlate failed authentication attempts by source IP.

The main lesson from the project was that security monitoring is not only about writing a detection rule. The logs have to be understood first, the detection has to be tested against real behavior, and the results have to be verified before treating an event as an alert.

This project is part of my ongoing cybersecurity and Linux security lab work.
