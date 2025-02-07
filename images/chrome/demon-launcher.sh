#!/bin/bash 

export DISPLAY_NUM=99
export DISPLAY=":$DISPLAY_NUM"

echo "--> All supervisor configuration files available: ${SUPERVISOR_CONF_PATH}"
echo "--> Logs path: ${SPRUT_LOGS_PATH}"

echo "---> Launch chromedriver..."
DISPLAY="$DISPLAY" /usr/bin/chromedriver --port=4444 --verbose --allowed-ips="" --allowed-origins=* &
echo "---> Chromedriver launched on port 4444"

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
