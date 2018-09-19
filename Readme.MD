# Introduction
This will show how to dockerize MQTT Broker.

# Requirements
* Docker -CE
* Docker Composer
* MQTT installed locally

# Configure

# Deploying
* Pull the master branch and open a terminal window in master
* create pwfile in *config* folder `touch config/pwfile`
* create database in *data* folder `touch data/mosquitto.db`
* create lof file in *log* folder `touch log/mosquitto.log`
## Edit compose file
Open docker-compose.yml with a text editor
In the volumes part
``` 
 - /media/nimz/Library/RAHASAK/AirQuality/docker_mqtt/config:/mosquitto/config
 - /media/nimz/Library/RAHASAK/AirQuality/docker_mqtt/data:/mosquitto/data
 - /media/nimz/Library/RAHASAK/AirQuality/docker_mqtt/log:/mosquitto/log
```
give the absolute path to the *config*, *data* and *log* folders.
`- Absolute_path_to_your_folder:/mosquitto/destination_folder`

This will mount those folders in the docker image we create

## Add username and password
you can add users to the MQTT with the following command. You can add one or more.<br/>
(you may need to install moasquiito on local computer to run this)<br/>
PS - you can add users while the broker is running. No need to restart.<br/>
Give Username in `USERNAMEGOESHERE` and password in `PASSWORDGOESHERE`.<br/>
`mosquitto_passwd -b config/pwfile USERNAMEGOESHERE PASSWORDGOESHERE`<br/>
this will store username and encrypted password in the pwfile. you can open it and see if the command worked correctly

## Dockerize
* Run `docker-compose up -d` to create the image
* Then you can check if the broker is up and running by `docker ps -a` command
* Test the broker(you can run mqtt client in host PC and connect to *localhost* with port *1883*)
