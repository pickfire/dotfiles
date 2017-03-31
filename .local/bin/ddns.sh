#!/usr/bin/env bash
# Simple script to update ip to changeip.com

USER='user'
PASS='pass'
LOG=/var/log/ip
IP=$(curl -x '' -s https://4.ifcfg.me/ip)

[ ! -f $LOG ] && { echo $IP > $LOG; echo Creating $LOG; }

# Check if IP is updated
if [ $(($(date +%s)-$(date -r $LOG +%s))) -ge $((60*60*24*30)) \
  -o $IP != $(tail -n1 $LOG) ]; then

  # Update IP in /etc/nsd/pickfire.tk.zone
  sed -i "s/[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+/$IP/" /etc/nsd/*.tk.zone
  nsd-control reload || echo 'nsd-control reload failed' &>2

  # Update IP in ChangeIP.com
  curl -x '' -u "$USER:$PASS" "https://nic.ChangeIP.com/nic/update"
  echo "$IP" >> $LOG
fi
