# Dockerfile-OSRM

### How to Build 
```sh
docker build -t osrm-image .
```

### How to use this image

```sh
docker run -d -p 5000:5000 osrm-image
```

### Access on Browser
```sh
http://<your docker host ip address>:5000/nearest/v1/driving/13.388860,52.517037?number=3&bearings=0,20
http://<your docker host ip address>:5000/route/v1/driving/polyline(ofp_Ik_vpAilAyu@te@g`E)?overview=false
http://<your docker host ip address>:5000/route/v1/driving/13.388860,52.517037;13.397634,52.529407;13.428555,52.523219?overview=false
```

# For More Details:-
```sh
https://github.com/Project-OSRM/osrm-backend/wiki/Server-API-v5,-current
```
