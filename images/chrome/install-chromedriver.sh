#!/bin/bash

#Check if the Chrome version argument is provided
if [ -z "$CHROME_VERSION" ]; then
  echo "[ERROR]: Chrome version variable is not provided."
  echo "USE: docker run -e CHROME_VERSION=117.0.5938.92"
  exit 1
fi

CHROME_VERSION=$1
MAJOR_CHROME_VERSION=$(echo "$CHROME_VERSION" | cut -d'.' -f1)

if [ "$MAJOR_CHROME_VERSION" -le 114 ]; then
  echo "---> Download from old location."
  CHROMEDRIVER_URL="https://chromedriver.storage.googleapis.com/${CHROME_VERSION}/chromedriver_linux64.zip"
  LOCAL_PATH="."
elif [ "$MAJOR_CHROME_VERSION" -ge 115 ]; then
  echo "---> Download from new location."
  CHROMEDRIVER_URL="https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/${CHROME_VERSION}/linux64/chromedriver-linux64.zip"
  LOCAL_PATH="chromedriver-linux64"
fi

CHROMEDRIVER_LOCATION="/usr/bin"

# Set the download destination
DOWNLOAD_DESTINATION="./chromedriver_linux64.zip"

# Download ChromeDriver
echo "---> Downloading ChromeDriver version ${CHROME_VERSION}..."
wget -O "chromedriver_linux64.zip" "${CHROMEDRIVER_URL}"

if [ $? -eq 0 ]; then
  echo "---> Chromedriver ${CHROME_VERSION} downloaded successfully."
else
  echo "[ERROR] Failed to download Chromedriver version ${CHROME_VERSION}. Please check the CHROME_VERSION or try again later."
  exit 1
fi

# Unzip the downloaded file
echo "---> Unzipping the downloaded file..."
unzip -o chromedriver_linux64.zip
# Make the chromedriver file executable
chmod +x "${LOCAL_PATH}/chromedriver"

mv "${LOCAL_PATH}/chromedriver" ${CHROMEDRIVER_LOCATION} 
chown ${USERNAME}:${USERNAME} "${CHROMEDRIVER_LOCATION}/chromedriver" 

echo "---> Removing old files..."
rm -rf chromedriver*

echo "---> ChromeDriver version ${CHROME_VERSION} downloaded successfully!"
