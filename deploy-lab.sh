#!/usr/bin/env bash

# Define variables - edit these if required
NETWORK=pwsh-labs
DATAVOL=pwsh-lab-exercises
DATAFOLDER=/pwsh-labs/exercises
PWSHNAME=pwsh-lab
PWSHVER=1.0
WEBSSHNAME=webssh-lab
WEBSSHVER=1.0
WEBSSHEXPOSED=8000

MAXSVR=5

# You shouldn't need to edit below here :)

echo "*** Building Images ***"

docker build -t pwsh-lab:$PWSHVER pwsh-lab/
docker build -t webssh-lab:$WEBSSHVER webssh-lab/


echo "*** Starting PowerShell Lab Environment ***"

# Create Lab Environment
echo  - Configuring Docker network and Volumes
docker network create $NETWORK
docker volume create $DATAVOL

# Clean up any conflicting containers
echo  - Clearing up...
docker stop $WEBSSHNAME || true ; docker rm $WEBSSHNAME || true
for i in $(eval echo $PWSHNAME{1..$MAXSVR}) ; do docker stop $i || true ; docker rm $i || true ; done

echo  - Starting Powershell Servers
# Create Powershell Containers
for i in $(eval echo $PWSHNAME{1..$MAXSVR}); do

    echo  -- $i
    docker run -d --name $i --network $NETWORK --mount source=$DATAVOL,destination=$DATAFOLDER,readonly pwsh-lab:$PWSHVER

done

# Create WebSSH Container
echo  - Starting WebSSH $WEBSSHNAME
docker run -d --name $WEBSSHNAME --network $NETWORK -p $WEBSSHEXPOSED:8888 pwsh-lab:$PWSHVER

echo "*** Deploy Complete ***"