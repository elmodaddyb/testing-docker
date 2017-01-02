# testing-docker
A docker container for continuous integration tests


## Building the Container

```
docker build -t elmodaddyb/testintegration .
```

### Run the Container 

```
docker run --privileged -p 8080:8080 -d -t elmodaddyb/testintegration:v1
```

#### Why `--privileged`
Chrome uses sandboxing, therefore if you try and run Chrome within a non-privileged container you will receive the following message:

"Failed to move to new namespace: PID namespaces supported, Network namespace supported, but failed: errno = Operation not permitted".

The --privileged flag gives the container almost the same privileges to the host machine resources as other processes 
running outside the container, which is required for the sandboxing to run smoothly.


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