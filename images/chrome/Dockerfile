ARG TAG=latest

FROM browser-base:${TAG}

ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

USER root

RUN addgroup ${USERNAME} && chown ${USERNAME}:${USERNAME} /opt

RUN curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo 'deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google.list

RUN apt update && \
    apt -y --no-install-recommends install \
    libdbus-1-3 \
    iproute2 \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcairo2 \
    libcups2 \
    libgbm1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libu2f-udev \
    libvulkan1 \
    libxkbcommon0 \
    xdg-utils
 

COPY install-chrome.sh install-chromedriver.sh demon-launcher.sh entrypoint.sh /

RUN chmod 4755 ./install-chrome.sh ./install-chromedriver.sh ./demon-launcher.sh

RUN chmod +x /entrypoint.sh

EXPOSE 4444 5900

ENTRYPOINT ["/entrypoint.sh"]
