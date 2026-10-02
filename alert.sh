#!/bin/bash
SIREN=$(printf '\U1F6A8 CRITICAL SECURITY ALERT' )
RESULT=$(journalctl --since "5 minutes ago" --unit "ssh"  \
| grep "Failed password"  \
| awk '{print $11}'  \
| sort  \
| uniq -c \
| awk '$1 >= 5 {print $1, $2}')
if  [[ -n "$RESULT" ]]; then
while read -r ATTEMPT IP; do
MESSAGE="$SIREN: Possible SSH Brute Force
Source IP: $IP
Number of Attempt: $ATTEMPT
Time block: 5minutes
$(date)"
printf '%s\n' "$MESSAGE" | wall
printf '%s\n' "$MESSAGE" >> /var/log/alert.log
done  <<< $RESULT
fi
