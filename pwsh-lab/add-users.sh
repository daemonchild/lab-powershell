#!/bin/bash
# Creates a number of users

# Define variables - edit these as required
MAXUSERS=10
LABBASE=/pwsh-labs
GROUPNAME=powershell
USERPASS=CorrectHorseBatteryStaple
USERNAME=user
USERHOME=$LABBASE/users

# You shouldn't need to edit below here :)

# Create new user home folder
if [ ! -d "$USERHOME" ]; then
	mkdir -p $USERHOME
fi

# Create group
echo " - Creating Group $GROUPNAME"
groupadd -g 2000 $GROUPNAME

# Configure folder permissions
chmod -R 644 $LABZONE
chown -R root:$GROUPNAME $LABHOME

# Create some users
for u in $(seq -f "%02g" 1 $MAXUSERS); do

    echo " - Adding $USERNAME$u:$USERPASS into $USERHOME/$USERNAME$u"
    useradd -m -d $USERHOME/$USERNAME$u -c "PowerShell Lab User" -s /usr/bin/pwsh  $USERNAME$u
    echo "$USERNAME$u:$USERPASS" | chpasswd
    usermod -a -G $GROUPNAME $USERNAME$u
    chmod 700 $USERHOME/$USERNAME$u

done