#!/bin/bash
SIREN=$(printf '\U0001f6a8 CRITICAL SECURITY ALERT')
RESULT=$(journalctl --since "3 minutes ago" --unit "ssh"  \
| grep "Failed password"  \
| awk '{
        for (i=1; i<NF; i++){
                if ($i == "from") {
                        print $(i+1)
                        break
                        }
                }
        }' \
| sort \
| uniq -c \
| awk '$1 >= 5 {print $1, $2}')
#NF=Number of Fields
if  [[ -n "$RESULT" ]]; then
while read -r ATTEMPT IP; do
MESSAGE="$SIREN: Possible SSH Brute Force
Source IP: $IP
Number of Attempt: $ATTEMPT
Time block: 3 minutes
$(date)"
printf '%s\n' "$MESSAGE" | wall
printf '%s\n' "$MESSAGE" >> /var/log/alert.log
done  <<< "$RESULT"
fi
