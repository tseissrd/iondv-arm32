# IONDV-Basic for Arm32

## About
The context for building docker containers with mongodb-3.2.12 and iondv-basic ( https://hub.docker.com/r/iondv/basic )
arm32 compatible mongodb container is based on https://github.com/robertsLando/MongoDB-OrangePI
mongodb binaries are provided under GNU AGPL v3.0

IONDV. Basic is designed to quickly launch simplest [IONDV. applications](https://github.com/iondv/framework) that do not require a complete build cycle. The image has built-in automatic deployment of any iondv application mounted in the applications folder.

IONDV configuration was tested for [ASUS Tinker-Board](https://www.asus.com/us/Single-Board-Computer/Tinker-Board/)

Spec.: Rockchip Quad-Core RK3288 1.8GHz/2Gb/ARM Mali-T764 600 GPU/SDIO3.0/microSD/WiFi/BT4.0/LAN/HD/Audio. Debian 9.

## Run

To run mongodb perform:

```
docker run -d --name mongodb --rm -p 27017:27017 -v mongodb_data:/data/db --network mongonet iondv/arm32-mongodb
```

here your local database from mongodb_data will be mounted in the container.  

Note that connecting to the database is done with the address equal to the argument of --name (e.g. "mongodb") which resolves to whatever ip the running container has.  

"mongonet" here corresponds to the docker network used by your containers, if you don't have one:

```
docker network create <name>
```

Running iondv-basic is done as descripted in https://hub.docker.com/r/iondv/basic (one can use user defined networks instead of linking if mongodb is ran in a separate network (e.g. "mongonet")).   
  
For example, if your iondv application is placed in /workspace/nutrition-tickets:

```
docker run -d --name iondv-basic -v /workspace/nutrition-tickets:/var/www/applications/nutrition-tickets --rm -p 8888:8888 --network mongonet iondv/arm32-basic
```

## Docker build
### Build iondv-basic docker image

Necessary steps to build the iondv-basic - install docker CE:

```
sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EFCD88
sudo add-apt-repository "deb [arch=armhf] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER
sudo apt-get install git
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm update -g npm
sudo npm install -g node-gyp gulp bower
```

Next build an empty iondv app structure. Clone the iondv-framework into any folder (e.g. iondv-app) and proceed with following the instructions given in https://github.com/iondv/framework/blob/master/docs/ru/readme.md

```
git clone https://github.com/iondv/framework iondv-app
cd modules
git clone https://github.com/iondv/registry
git clone https://github.com/iondv/rest
git clone https://github.com/iondv/ionadmin
git clone https://github.com/iondv/dashboard
cd ..
cd applications
git clone https://github.com/iondv/viewlib
cd ..
export NODE_PATH='pwd'
sudo npm install
sudo gulp build
```

Place the contents of iondv-basic folder of this repository into iondv-app.

At this point the context for building iondv-basic is set.

To build arm32-iondv-basic

```
cd iondv-app
docker build -t iondv/arm32-basic:3.1.0 -t iondv/arm32-basic:latest .
```


### Build arm32-mongodb
Building the containers is done in appropriate directories with:

To build mongo arm32-mongodb

```
cd mongodb
docker build -t iondv/arm32-mongodb:3.12.2 -t iondv/arm32-mongodb:latest .
```
