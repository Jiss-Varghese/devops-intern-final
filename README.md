# DevOps Intern Final Assessment

https://github.com/Jiss-Varghese/devops-intern-final/actions/workflows/ci.yml/badge.svg


**Name:** Jiss Varghese<br>
**Date:** 18 August 2026<br>
**Repository:** devops-intern-final

# Project Overview

This project demonstrates a complete DevOps workflow using open-source tools and practices.

 The workflow covers:

## Git & GitHub
## Linux & Bash Scripting
## Docker
## CI/CD with GitHub Actions
## Container Deployment with Nomad
## Monitoring with Grafana Loki and Grafana Alloy
``` text
DevOps Workflow
GitHub
   ↓
Python Application
   ↓
Docker Image
   ↓
GitHub Actions CI/CD
   ↓
Nomad Deployment
   ↓
Grafana Loki + Alloy Monitoring
```
Project Structure

 The final repository is  containing  the following structure:

### devops-intern-final/

```text

│
├── README.md
├── hello.py
├── Dockerfile
│
├── scripts/
│   └── sysinfo.sh
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── nomad/
│   └── hello.nomad
│
└── monitoring/
    ├── loki-config.yml
    └── alloy-config.alloy
```
## Step 1 — Git & GitHub Setup 


 Create a public GitHub repository and initialize the project 

 **Repository name:** devops-intern-final

The repository is public and contains all project source code, configuration files, documentation, and screenshots.

### Application

**The sample Python application is stored in:** hello.py

 

**The application prints:** Hello, DevOps!

**Run the Application:** python3 hello.py

 **Output:** Hello, DevOps!

Git Commands Used
#### git init
#### git add .
#### git commit -m "Initial commit"
#### git branch -M main
#### git remote add origin <https://github.com/Jiss-Varghese/devops-intern-final.git>
#### git push -u origin main

Output<br>
`-` Public GitHub repository created<br>
`-` README.md added<br>
`-` hello.py added

Initial Git commit pushed to GitHub

#### git remote add origin https://github.com/Jiss-Varghese/devops-intern-final.git
#### git remote -v
#### git add README.md hello.py
#### git commit -m "Add initial project files"
#### git branch -M main
#### git push -u origin main


## step 2 - Linux & Scripting Basics

Create a Bash script that displays basic system information.

**The script is located at:** scripts/sysinfo.sh

The script displays:<br>
`-`Current username<br>
`-`Current date and time<br>
`-`Disk usage<br>
**Make the Script Executable:** chmod +x scripts/sysinfo.sh

**Run the Script:** ./scripts/sysinfo.sh

The script uses Linux/macOS commands such as:

whoami<br>
date<br>
df -h<br>
 
 Output<br>
**User:** jiss<br>
**Date:** Mon Aug 18 19:00:00 SGT 2026<br>
**Disk Usage:**  (screenshot attached)

Output<br>
`-`Bash system-information script created<br>
`-`Script made executable<br>
`-`System information successfully displayed

## step 3 - Docker Basics


Containerize the Python application using Docker.

**The Docker configuration is stored in:** Dockerfile


The Docker image uses Python as its base image and runs hello.py.

Build the Docker Image

**From the project root:** docker build -t hello-devops .

**Check the image:** docker images<br>
**Run the Container:** docker run --rm hello-devops

 Output

Hello, DevOps!

Useful Docker Commands

**Check running containers:** docker ps

**Check all containers:** docker ps -a

**Check images:** docker images

**Remove an image:** docker rmi hello-devops

Output<br>
`-`Dockerfile created<br>
`-`Docker image successfully built<br>
`-`Python application successfully executed inside a container

#### git status
#### git add Dockerfile README.md
#### git commit -m "Add Docker containerization"
#### git push


## step 4 - CI/CD with GitHub Actions


Create an automated CI pipeline using GitHub Actions.

**The workflow is stored in:** .github/workflows/ci.yml

CI Pipeline

The workflow performs the following steps:

`-`Checks out the repository<br>
`-`Sets up Python<br>
`-`Runs the Python application<br>
`-`Verifies that the application executes successfully<br>

GitHub Actions Workflow

**The workflow uses:** actions/checkout<br>
**actions/setup-python:** Python version 3.12

Trigger

The workflow runs automatically when code is pushed to the repository.

on: push
Check the Workflow

After pushing code:<br>

##### Open the GitHub repository<br>
##### Select Actions<br>
##### Select the CI workflow<br>
##### open the workflow and look for: Run hello.py <br>
 
 Output<br> 
Hello,DevOps!

Check the workflow run.

A successful workflow indicates that the application passes the CI step.

Output<br>
`-`GitHub Actions workflow created<br>
`-`Automated testing/execution configured<br>
`-`CI pipeline successfully executed on GitHub


Commit and push the workflow

#### git add .github/workflows/ci.yml<br>
#### git commit -m "Add GitHub Actions CI pipeline"<br>
#### git push


#### git add README.md<br>
#### git commit -m "Add CI status badge to README.md"<br>
#### git push



Nomad pending


Create monitoring directory


mkdir monitoring

Create Loki configuration

vim monitoring/loki-config.yml

auth_enabled: false

server:
  http_listen_port: 3100

common:
  path_prefix: /loki
  replication_factor: 1

  ring:
    kvstore:
      store: inmemory

  storage:
    filesystem:
      chunks_directory: /loki/chunks
      rules_directory: /loki/rules

schema_config:
  configs:
    - from: 2024-01-01
      store: tsdb
      object_store: filesystem
      schema: v13
      index:
        prefix: index_
        period: 24h


       Start Loki

        docker run -d \
  --name loki \
  -p 3100:3100 \
  -v "$(pwd)/monitoring/loki-config.yml:/etc/loki/config.yml" \
  grafana/loki:latest \
  -config.file=/etc/loki/config.yml

  docker ps

  grafana/loki

  Check Loki:
  curl http://localhost:3100/ready
  ready

  run again:
  will get ready
  Check Loki metrics:
curl http://localhost:3100/metrics

Send a test log to Loki

curl -X POST http://localhost:3100/loki/api/v1/push \
  -H "Content-Type: application/json" \
  --data-raw '{
    "streams": [
      {
        "stream": {
          "job": "hello-devops"
        },
        "values": [
          ["'$(date +%s%N)'", "Hello from DevOps monitoring"]
        ]
      }
    ]
  }'

  Query the log

  curl -G -s "http://localhost:3100/loki/api/v1/query_range" \
  --data-urlencode 'query={job="hello-devops"}'
Hello from DevOps monitoring

  Create loki_setup.txt


vim monitoring/loki_setup.txt
Grafana Loki Monitoring Setup
=============================

1. Loki Configuration
---------------------

Loki configuration is stored in:

monitoring/loki-config.yml


2. Start Loki
-------------

Loki was started locally using Docker:

docker run -d \
  --name loki \
  -p 3100:3100 \
  -v "$(pwd)/monitoring/loki-config.yml:/etc/loki/config.yml" \
  grafana/loki:latest \
  -config.file=/etc/loki/config.yml


3. Check Loki
-------------

The Loki readiness endpoint was checked using:

curl http://localhost:3100/ready


4. Send a Test Log
------------------

A test log was sent to Loki using the Loki push API.


5. View Logs
------------

Logs can be queried using:

curl -G -s "http://localhost:3100/loki/api/v1/query_range" \
  --data-urlencode 'query={job="hello-devops"}'


6. Example Log
--------------

Hello from DevOps monitoring


7. Docker Container
-------------------

The Loki container can be checked with:

docker ps

and its logs can be viewed with:

docker logs loki

Add Monitoring to README

## 6. Monitoring with Grafana Loki

Grafana Loki is used for centralized log collection and querying.

### Start Loki

```bash
docker run -d \
  --name loki \
  -p 3100:3100 \
  -v "$(pwd)/monitoring/loki-config.yml:/etc/loki/config.yml" \
  grafana/loki:latest \
  -config.file=/etc/loki/config.yml

  Check Loki

  curl http://localhost:3100/ready
  ready

Want to see ONLY the message:


Run this command:
curl -G -s "http://localhost:3100/loki/api/v1/query_range" \
  --data-urlencode 'query={job="hello-devops"}' \
  | grep -o 'Hello from DevOps monitoring'


  



