#!/bin/bash 

if [ -z "$CHROME_VERSION" ]; then
    echo "[ERROR]: Chrome version variable is not provided."
    echo "USE: docker run -e CHROME_VERSION=117.0.5938.92"
    exit 1
fi

CHROME_VERSION=$1

if [[ "$CHROME_VERSION" == "beta" || "$CHROME_VERSION" == "stable" || "$CHROME_VERSION" == "unstable" ]]; then
  URL="https://dl.google.com/linux/direct/google-chrome-${CHROME_VERISON}_current_amd64.deb"
else
  URL="http://mirror.cs.uchicago.edu/google-chrome/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}-1_amd64.deb"
fi

FILENAME="google-chrome-stable_${CHROME_VERSION}_amd64.deb"

# Download Chrome package
echo "---> Downloading Google Chrome version ${CHROME_VERSION}..."
wget -O "$FILENAME" "$URL"

# Check if the download was successful
if [ $? -eq 0 ]; then
  echo "---> Google Chrome version ${CHROME_VERSION} downloaded successfully."
else
  echo "[ERROR] Failed to download Google Chrome version ${CHROME_VERSION}. Please check the CHROME_VERSION or try again later."
  exit 1
fi

# Install Chrome package using dpkg
echo "---> Installing Google Chrome..."
dpkg -i "$FILENAME"

# Check if installation was successful
if [ $? -eq 0 ]; then
  echo "---> Google Chrome version ${CHROME_VERSION} installed successfully."
else
  echo "[ERROR] Failed to install Google Chrome version ${CHROME_VERSION}. Please check the CHROME_VERSION or try again later."
  exit 1
fi

# Clean up by removing the downloaded package
rm "$FILENAME"

sed -i -e 's@exec -a "$0" "$HERE/chrome"@& --no-sandbox --disable-gpu@' /opt/google/chrome/google-chrome && \
    chown ${USERNAME}:${USERNAME} /opt/google/chrome/chrome-sandbox && \
    chmod 4755 /opt/google/chrome/chrome-sandbox && \
    google-chrome --version && \
    rm -Rf /tmp/* && rm -Rf /var/lib/apt/lists/*

echo "---> Installation completed. Enjoy using Google Chrome!"
