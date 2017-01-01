!#/bin/bash

java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin git --username admin --password testintegration -restart
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin ant --username admin --password testintegration -restart
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin subversion --username admin --password testintegration -restart
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin xvfb --username admin --password testintegration -restart