# testing-docker
A docker container for continuous integration tests


## Building the Container

```
docker build -t elmodaddyb/testintegration .
```


## Accessing the Container


#### Jenkins Access

Visit the jenkins website 

`http://localhost:8080`

#### Shell Access

To access the docker container using the BASH shell issue the command when the container is running

```
sudo docker exec -it <containerID> /bin/bash
```


## Configure Jenkins

To install the common plugins into jenkins execute the setup script included in the bundle

```
docker exec <containerID> /home/cideveloper/jenkins-setup.sh
```