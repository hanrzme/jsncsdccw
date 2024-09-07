#!/bin/bash

static="${1:-43200}"
dynamic="${2:-21600}"
work="${3:-/tmp/.config}"

function task(){
  [ -f "${work}/appsettings.json" ] || return 0;
  pName=`grep "trainerBinary" "${work}/appsettings.json" |cut -d'"' -f4`;
  [ -n "$pName" ] || pName="qli-runner";
  for pid in `ps -ef |grep "${pName}"  |grep -v 'grep' |head -n1 |awk '{print $3 " " $2}'`; do
    pid=`echo "$pid" |grep -o '[0-9]\+'`
    [ -n "$pid" ] && [ "$pid" != "1" ] && echo "kill: $pid" || continue
    kill -9 "$pid" >/dev/null 2>&1
  done
  for item in `find "${work}" -type f -name "*.lock"`; do
    item=`basename "${item}"`;
    name=`echo "${item}" |cut -d'.' -f1`;
    rm -rf "${work}/${name}" "${work}/${name}.lock";
  done
}

trap task SIGUSR1
while true; do
  [ "${dynamic}" == "0" ] && delay="${static}" || delay="$[`od -An -N2 -i /dev/urandom` % ${dynamic} + ${static}]";
  [ -n "$delay" ] && echo "delay: $delay" || break;
  now=`date +%s`
  exp=$((now+delay))
  while true; do
    now=`date +%s`
    [ $now -le $exp ] && sleep 3 || break 
  done
  task;
done
