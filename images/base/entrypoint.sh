#!/bin/bash

export DISPLAY_NUM=99
export DISPLAY=":$DISPLAY_NUM"

echo "--> Launch entrypoint.sh"
echo "--> All supervisor configuration files avaliable: ${SUPERVISOR_CONF_PATH}"
echo "--> Sprut logs path: ${SPRUT_LOGS_PATH}"

if [ "$ENABLE_VNC" = "true" ]; then
    echo "--> Starting fluxbox and VNC server. Screen resolution: ${SCREEN_RESOLUTION}. VNC user: ${USERNAME}"
    /usr/bin/supervisord --configuration ${SUPERVISOR_CONF_PATH}/fluxbox.conf & \
    /usr/bin/supervisord --configuration ${SUPERVISOR_CONF_PATH}/vnc.conf & \
    wait 
else
    echo "--> Starting fluxbox. Params: ${SCREEN_RESOLUTION}"
    /usr/bin/supervisord --configuration ${SUPERVISOR_CONF_PATH}/fluxbox.conf & \
    wait
fi

