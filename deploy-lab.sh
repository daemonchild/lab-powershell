#!/usr/bin/env bash

# Define variables - edit these if required
LABVER=1.0
NETWORK=pwsh-labs
DATAVOL=pwsh-lab-exercises
DATAFOLDER=/pwsh-labs/exercises
PWSHNAME=pwsh-lab
WEBSSHNAME=webssh-lab
WEBSSHEXPOSED=8000

MAXSVR=5

# You shouldn't need to edit below here :)

echo "*** Building Images ***"

CURRENTDIR = $PWD

BUILDLIST = pwsh-lab pwsh-lab

for c in $BUILDLIST ; do

    cd $c
    docker build -t $c:$LABVER .
    cd $CURRENTDIR

done


echo "*** Starting PowerShell Lab Environment ***"

# Create Lab Environment
echo  - Configuring Docker network and Volumes
docker network create $NETWORK
docker volume create $DATAVOL

# Clean up any conflicting containers
echo  - Clearing up... Errors expected on first run
docker stop $WEBSSHNAME || true ; docker rm $WEBSSHNAME || true
for i in $(eval echo $PWSHNAME{1..$MAXSVR}) ; do docker stop $i || true ; docker rm $i || true ; done

echo  - Starting Powershell Servers
# Create Powershell Containers
for i in $(eval echo $PWSHNAME{1..$MAXSVR}); do

    echo  -- $i
    docker run -d --name $i --network $NETWORK --mount source=$DATAVOL,destination=$DATAFOLDER,readonly pwsh-lab:$LABVER

done

# Create WebSSH Container
echo  - Starting WebSSH $WEBSSHNAME
docker run -d --name $WEBSSHNAME --network $NETWORK -p $WEBSSHEXPOSED:8888 webssh-lab:$LABVER

echo "*** Deploy Complete ***"