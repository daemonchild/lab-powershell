# lab-powershell
Lab Environment for Powershell Core

## Aims
This project creates a self contained lab environment for a classroom learning PowerShell.

## Installation

`
$ git clone https://github.com/daemonchild/lab-powershell.git
Cloning into 'lab-powershell'...
$ cd lab-powershell
$ bash ./deploy.sh
[lovely docker magic happens]
`

## Logical Network Layout

There are a minimum of two containers.
The WebSSH proxy accepts HTTP connections on port 8000.
All SSH commands, including authentication attempts, are proxied through to the endpoint SSH server.

`[Client Browser] --8000/tcp--> [WebSSH Proxy] --22/tcp--> [Powershell Lab Server(s)]`

The lab environment is intended to be run behind an nginx reverse proxy (or similar) in order to provide TLS connectivity.
__You really don't want this over plain text HTTP if you care about your environment.__

This is how I configured this for a workshop I was running on PowerShell:

`[Client Browser] --443/tcp-->  [Nginx Reverse Proxy] --8000/tcp--> [WebSSH Proxy] --22/tcp--> [Powershell Lab Server(s)]`

