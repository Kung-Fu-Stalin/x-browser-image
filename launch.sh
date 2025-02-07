#/bin/bash 

echo "Launch chrome container"
docker run --shm-size=4g -e CHROME_VERSION=117.0.5938.92 -p 5900:5900 -p 4444:4444 chrome-custom:latest