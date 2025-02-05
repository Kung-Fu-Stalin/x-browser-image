#!/bin/bash 

echo "--> Launch entrypoint.sh"

if which google-chrome >/dev/null 2>&1; then
    echo "--> Google Chrome is installed..."
else
    echo "--> Launch install-chrome.sh script. Google Chrome version: ${CHROME_VERSION}"
    ./install-chrome.sh ${CHROME_VERSION}
    if [ $? -eq 1 ]; then
        echo "[ERROR] install-crhome.sh script finished with exit code 1."
        echo "Exiting..."
        exit 1
    fi
fi

if which chromedriver >/dev/null 2>&1; then
    echo "--> Chrome driver is already installed..."
else
    echo "--> Launch install-chromedriver.sh. Google Chrome version: ${CHROME_VERSION}"
    ./install-chromedriver.sh ${CHROME_VERSION}
    if [ $? -eq 1 ]; then
        echo "[ERROR] install-chromedriver.sh script finished with exit code 1."
        echo "Exiting..."
        exit 1
    fi
fi

echo "--> Launch demon-launcher.sh."
su -s /bin/bash ${USERNAME} -c "/demon-launcher.sh"
