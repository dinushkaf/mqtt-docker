#!/bin/bash


echo "creating files..."
rm docker-compose.yml config/pwfile log/mosquitto.log data/mosquitto.db
mkdir config data log
touch config/pwfile log/mosquitto.log data/mosquitto.db
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
echo "Creating config file..."
echo "persistence true
persistence_file mosquitto.db
persistence_location /mosquitto/data/
autosave_interval 1800
password_file /mosquitto/config/pwfile
allow_anonymous false
log_timestamp true  
log_dest file /mosquitto/log/mosquitto.log" > config/mosquitto.conf
echo "Creating composer script..."
echo $'version: \"3.3\"

services:
  mqtt:
    image: eclipse-mosquitto
    ports:
      - \"1883:1883\"
    volumes:
      - '$SCRIPTPATH$'/config:/mosquitto/config
      - '$SCRIPTPATH$'/data:/mosquitto/data
      - '$SCRIPTPATH$'/log:/mosquitto/log' > docker-compose.yml
echo "Add users to broker "
echo "Enter username and password as USERNAME PASSWORD and hit enter. (seperate username and password with a space)"
echo "Type end and hit enter to quit adding users"
while [ "${INPUT[0],,}" != "end" ]
do
	read -p "> " -a INPUT
	if [ ${#INPUT[@]} == 2 ]
	then
		$( mosquitto_passwd -b "config/pwfile" "${INPUT[0]}" "${INPUT[1]}" )
		echo "User added"
	elif [ "${INPUT[0],,}" != "end" ]
	then
		echo "username or password is missing"
	fi
done
echo "Stopping local mosquitto service..."
$(service mosquitto stop)
echo "Creating docker image..."
$(docker-compose up -d)
echo "DONE!"

