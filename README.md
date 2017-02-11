# testing-docker
A docker container for continuous integration tests


## Building the Container

```
docker build -t elmodaddyb/testintegration .
```

### Run the Container

#### Create a data volume

```
docker volume create --name jenkins-data
```

#### Run the Container

```
docker run --privileged -d -p 8080:8080 --name jenkins -v jenkins-data:/opt/jenkins elmodaddyb/testingintegration
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
docker exec <containerID> /opt/jenkins/jenkins-setup.sh
```


### Setup Node Gradle User home

When gradle runs, it uses a cache.  The cache is locked for various reasons.  If you configure multiple executors on one jenkins instance,
then this could cause blocking and delays.  A recommendation is to enable a `$GRADLE_USER_HOME` variable at the **Node** level that uses the `$EXECUTOR_NUMBER`.
This will result in a Gradle cache that is specific to an executor.  

This takes advantage of the cache, but avoids the blocking situations.

#### To Add the GRADLE_USER_HOME variable

> Manage Jenkins -- Manage Nodes -- Environment Variables

Add the variable:

```
key = GRADLE_USER_HOME
value = $JENKINS_HOME/nodes/gradle/$EXECUTOR_NUMBER
```
