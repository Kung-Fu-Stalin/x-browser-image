# Define build arguments (only available during build)
ARG UBUNTU_RELEASE=22.04

# Base image (ARG values reset after FROM)
FROM ubuntu:${UBUNTU_RELEASE}

# Re-declare build args after FROM to persist them
ARG VNC
ARG USER
ARG RESOLUTION

# Define environment variables
ENV USERNAME=${USER}
ENV USER_HOME=/home/${USER}
ENV ENABLE_VNC=${VNC}
ENV SCREEN_RESOLUTION=${RESOLUTION}
ENV SPRUT_LOGS_PATH=/var/log/sprut
ENV SUPERVISOR_CONF_PATH=/var/sprut

# Ensure USERNAME is not empty 
RUN test -n "$USERNAME" || (echo "ERROR: USERNAME is empty" && exit 1)

# Skip any keyboard input
ENV DEBIAN_FRONTEND=noninteractive

# Set timezone
ENV TZ="UTC"
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
    apt clean && \
    rm -Rf /tmp/* && rm -Rf /var/lib/apt/lists/*

# Add new sprut user
RUN adduser --system --home "${USER_HOME}" --uid 2048 --ingroup root --disabled-password --shell /bin/bash "${USERNAME}"

# Create default directories and set permissions
RUN mkdir -p "${USER_HOME}/Downloads" \
    "${USER_HOME}/.fluxbox" \
    "${SUPERVISOR_CONF_PATH}" \
    "${SPRUT_LOGS_PATH}" && \
    chgrp -R 0 "${USER_HOME}" && \
    chown -R "${USERNAME}:root" "${SPRUT_LOGS_PATH}" && \
    chmod -R g=u "${USER_HOME}"

# Copy required files
COPY wallpaper/sprut-wallpaper.jpg /usr/share/images/fluxbox/
COPY sconf /var/sprut/
COPY fluxbox /usr/share/fluxbox/styles/
COPY --chown=${USERNAME}:root fluxbox ${USER_HOME}/.fluxbox/
COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

EXPOSE 5900

# Switch to the new user
USER ${USERNAME}

ENTRYPOINT ["/entrypoint.sh"]
