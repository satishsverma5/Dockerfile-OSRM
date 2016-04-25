# https://github.com/Project-OSRM/osrm-backend/wiki/Building-OSRM
# https://github.com/Project-OSRM/osrm-backend/wiki/Building-on-Ubuntu
# http://download.geofabrik.de/asia/india.html

#using debian:jessie for it's smaller size over ubuntu
FROM ubuntu:trusty

# Run updates and install deps
RUN apt-get update

RUN sudo apt-get install -y build-essential git cmake pkg-config \
         libbz2-dev libstxxl-dev libstxxl1 libxml2-dev \
         libzip-dev libboost-all-dev lua5.1 liblua5.1-0-dev libluabind-dev libtbb-dev wget vim

# Create Directory
RUN mkdir -p /var/www/OSRM  &&  cd /var/www/OSRM  && 
    git clone https://github.com/Project-OSRM/osrm-backend.git .

RUN mkdir -p /var/www/OSRM/build        &&
    cd /var/www/OSRM/build              && 
    cmake .. -DCMAKE_BUILD_TYPE=Release && 
    cmake --build .                     && 
    cmake --build . --target install


RUN cd /var/www/OSRM && 
    wget http://download.geofabrik.de/asia/india-latest.osm.pbf

RUN cd /var/www/OSRM && osrm-extract -p profile.lua india-latest.osm.pbf
RUN cd /var/www/OSRM && osrm-contract india-latest.osrm
#RUN cd /var/www/OSRM && osrm-routed india-latest.osrm

RUN apt-get -y autoclean
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /var/www

# add start.sh script
ADD start.sh /var/www
RUN chmod +x /var/www/start.sh

ENTRYPOINT ["/bin/bash", "/var/www/start.sh"]
