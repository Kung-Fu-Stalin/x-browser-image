#!/bin/bash

SCREEN_RESOLUTION=${SCREEN_RESOLUTION:-"1280x800x24"}
DISPLAY_NUM=99
DISPLAY=":$DISPLAY_NUM"

/usr/bin/xvfb-run -n "$DISPLAY_NUM" -s "-ac -screen 0 $SCREEN_RESOLUTION -noreset -listen tcp" /usr/bin/fluxbox -display "$DISPLAY" -log ${USER_HOME}/x.log & 
x11vnc -display "$DISPLAY" -passwd sprut -shared -forever -loop500 -rfbport 5900 -logfile ${USER_HOME}/vnc.log &

retcode=1
until [ $retcode -eq 0 ]; do
  sleep 0.1
done
