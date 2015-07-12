#!/bin/bash
# usage: screen watch ticketswapmonitor.sh

result=`curl -s https://www.ticketswap.nl/60885/welcome-to-the-future-festival-2015/1338/festival | grep -A2 "Aangeboden" | grep counter-value | awk 'NR > 1 {print $1}' RS='>' FS='<' | head -n 1`

if [[ $result -eq 0 ]]
then
  echo $"nothing"
else
  echo "New tickets for WTTF2015" | mail -s "New tickets for WTTF2015" alessandro@ams0.org
  sleep 10
fi
