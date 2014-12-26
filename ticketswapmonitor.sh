#!/bin/bash
# usage: screen watch ticketswapmonitor.sh

result=`curl -s https://www.ticketswap.nl/56831/next-mondays-hangover-fck-nye-2014 | grep -A2 "Aangeboden" | grep counte
r-value | awk 'NR > 1 {print $1}' RS='>' FS='<' | head -n 1`

if [[ $result -eq 0 ]]
then
  echo $"nothing"
else
  echo "New tickets for FCK NYE" | mail -s "New tickets for FCK NYE" alessandro@ams0.org
  sleep 10
fi
