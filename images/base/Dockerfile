# Set Ubuntu release manually 
ARG UBUNTU_RELEASE=22.04

# Build args
ARG USER=sprut
ARG USER_DIR=/home/${USER}
ARG RESOLUTION=1280x800x24

# Base image 
FROM ubuntu:${UBUNTU_RELEASE}

# Envarionment vars
ENV USERNAME=${USER:-sprut}
ENV USER_HOME=${USER_DIR:-/home/sprut}
ENV ENABLE_VNC=true
ENV SCREEN_RESOLUTION=${RESOLUTION:-1280x800x24}
ENV SPRUT_LOGS_PATH=/var/log/sprut
ENV SUPERVISOR_CONF_PATH=/var/sprut

# Skip any input from keyboard
ENV DEBIAN_FRONTEND=noninteractive

# Set timezone
ENV TZ "UTC"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt update && apt install -y fluxbox \
    x11vnc \
    xvfb \
    unzip \
    supervisor \
    vim \
    curl \
    wget \
    gnupg \
    feh && \
# Clean up after install
    apt clean && \
    rm -Rf /tmp/* && rm -Rf /var/lib/apt/lists/*

# Add new sprut user
RUN adduser --system --home ${USER_HOME} --uid 2048 --ingroup root --disabled-password --shell /bin/bash ${USERNAME}

# Create default dirs and give permissions on it 
RUN mkdir -p ${USER_HOME}/Downloads && \
    mkdir -p ${USER_HOME}/.fluxbox && \
    mkdir -p ${SUPERVISOR_CONF_PATH} && \
    mkdir -p ${SPRUT_LOGS_PATH} && \
    chgrp -R 0 ${USER_HOME} && \
    chown -R ${USERNAME}:root ${SPRUT_LOGS_PATH} && \
    chmod -R g=u ${USER_HOME} 

COPY wallpaper/sprut-wallpaper.jpg /usr/share/images/fluxbox/
COPY sconf /var/sprut/
COPY fluxbox /usr/share/fluxbox/styles/
COPY --chown=${USERNAME}:root fluxbox /home/sprut/.fluxbox/
COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

EXPOSE 5900

USER sprut

ENTRYPOINT ["/entrypoint.sh"]
