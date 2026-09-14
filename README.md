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



## Step 5 - Job Deployment with Nomad


Deploy the Docker container using HashiCorp Nomad.

**The Nomad job configuration is located at:** nomad/hello.nomad

**The job uses:**<br>

`-`Job type: service<br>
`-`Docker driver<br>
`-`1 task allocation<br>
`-`100 CPU units<br>
`-`128 MB memory

**Nomad Installation commands:**<br>
 
 brew tap hashicorp/tap<br>
 brew install hashicorp/tap/nomad<br>
 nomad version<br>

 Create a directory<br> 
   **name:** mkdir nomad<br>
    touch nomad/hello.nomad<br>
    vim nomad/hello.nomad
          
 Nomad Job<br>
    
    job "hello-devops" {
      datacenters = ["dc1"]

    type = "service"

    group "hello" {
    count = 1

    task "hello" {
      driver = "docker"

      config {
        image = "hello-devops:latest"

        
      }

      resources {
        cpu    = 100
        memory = 128
      }
      }
      }
      }



docker build -t hello-devops .<br>
docker images<br>
nomad agent -dev<br>

nomad status<br>
nomad job validate nomad/hello.nomad<br>
nomad job run nomad/hello.nomad<br>

Unhealthy : 1

Useful Commands for troubleshooting<br>

nomad job status hello-devops<br>
docker images | grep hello-devops<br>
docker run --rm hello-devops:latest<br>
nomad alloc status (ID)<br>

vim nomad/hello.nomad

    job "hello-devops" {
    datacenters = ["dc1"]

    type = "service"

    group "hello" {
    count = 1

    task "hello" {
      driver = "docker"

      config {
        image = "localhost:5001/hello-devops:latest"
        command = "python"
        args = [
          "-u",
          "-c",
          "import time; print('Hello, DevOps!', flush=True); time.sleep(3600)"
        ]
      }

      resources {
        cpu    = 100
        memory = 128
      }
      }
      }
      }
  


Docker Local Registry

For the Nomad deployment, the Docker image is stored in a local Docker registry.

**Start the Registry:** docker run -d \
  -p 5001:5000 \
  --name registry \
  registry:2<br>

**Tag the Image:** docker tag hello-devops:latest localhost:5001/hello-devops:latest<br>

**Push the Image:** docker push localhost:5001/hello-devops:latest<br>

**Verify the Registry:** curl http://localhost:5001/v2/hello-devops/tags/list<br>

nomad job stop hello-devops<br>
nomad job run nomad/hello.nomad<br>

Output<br>
**Healthy :** 1

#### git add nomad/hello.nomad README.md
#### git commit -m "Add Nomad deployment job"
#### git push


## Step 6 — Monitoring with Grafana Loki

The architecture will be:
``` text
Docker container
      │
      │ logs
      ▼
Grafana Alloy
      │
      │ Loki API
      ▼
Grafana Loki
```
Nomad is running your application container, while Docker/Alloy collects its logs.

Start Loki

Open another Terminal.

Run:<br>



docker run -d \
  --name loki \
  -p 3100:3100 \
  grafana/loki:latest \
  -config.file=/etc/loki/local-config.yaml

Check:

docker ps

 should see:

loki
Test Loki

Run:

curl http://localhost:3100/ready

should see:

ready

Check Loki labels

Run:

curl http://localhost:3100/loki/api/v1/labels

Loki should return JSON.

At this stage, Loki itself is running.

Install Grafana Alloy

If you use Homebrew:


brew install grafana/grafana/alloy

check:

alloy --version

Create monitoring folder

cd ~/devops-intern-final

Then:

mkdir -p monitoring

Create Alloy configuration



vim monitoring/alloy-config.alloy 

Run:

discovery.docker "containers" {
  host = "unix:///var/run/docker.sock"
}

discovery.relabel "containers" {
  targets = discovery.docker.containers.targets

  rule {
    source_labels = ["__meta_docker_container_name"]
    regex         = "/(.*)"
    target_label  = "container"
  }

  rule {
    source_labels = ["__meta_docker_container_image"]
    target_label  = "image"
  }

  rule {
    target_label = "job"
    replacement  = "hello-devops"
  }
}

loki.source.docker "containers" {
  host       = "unix:///var/run/docker.sock"
  targets    = discovery.relabel.containers.output
  forward_to = [loki.write.local.receiver]
}

loki.write "local" {
  endpoint {
    url = "http://host.docker.internal:3100/loki/api/v1/push"
  }
}

Run Alloy in Docker

Because Alloy needs access to the Docker socket


First remove an old Alloy container if one exists:


docker rm -f grafana-alloy 2>/dev/null || true

Then run:

docker run -d \
  --name grafana-alloy \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v "$(pwd)/monitoring/alloy-config.alloy:/etc/alloy/config.alloy:ro" \
  grafana/alloy:latest \
  run /etc/alloy/config.alloy

  Check :

  docker ps

  should see:

  grafana-alloy


Check Alloy logs

Run:

docker logs grafana-alloy --tail 50

Generate a log from your application

First run Docker application:

docker run -d \
  --name hello-logs \
  localhost:5001/hello-devops:latest \
  sh -c "echo 'Hello from container to Loki'; sleep 3600"

  check:

  docker logs hello-logs

  Expected:

  Hello from container to Loki


  Give Alloy a moment

Wait around 10–20 seconds.

Then check:

curl http://localhost:3100/loki/api/v1/labels


start seeing labels.

Query Loki

Run:

curl -G -s http://localhost:3100/loki/api/v1/query \
  --data-urlencode 'query={job="hello-devops"} |= "Hello from container to Loki"'



  should see:

  Hello from container to Loki





Create loki_setup.txt


vim monitoring/loki_setup.txt

Run:

Grafana Loki Monitoring Setup
=============================

1. Start Loki

Loki was started locally using Docker:

docker run -d \
  --name loki \
  -p 3100:3100 \
  grafana/loki:latest \
  -config.file=/etc/loki/local-config.yaml

2. Verify Loki

The Loki readiness endpoint was checked using:

curl http://localhost:3100/ready

Expected result:

ready

3. Start Grafana Alloy

Grafana Alloy was used to collect Docker container logs and forward them to Loki.

The Alloy configuration is stored in:

monitoring/alloy-config.alloy

4. Run Alloy

Alloy was started using Docker with access to the Docker socket:

docker run -d \
  --name grafana-alloy \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v "$(pwd)/monitoring/alloy-config.alloy:/etc/alloy/config.alloy:ro" \
  grafana/alloy:latest \
  run /etc/alloy/config.alloy

5. Generate a test log

A test Docker container was started with:

docker run -d \
  --name hello-logs \
  localhost:5001/hello-devops:latest \
  sh -c "echo 'Hello from container to Loki'; sleep 3600"

 

The log was verified with:

docker logs hello-logs

Expected output:

Hello from container to Loki

6. Query Loki

The logs can be queried with:




   curl -G -s http://localhost:3100/loki/api/v1/query_range \
  --data-urlencode 'query={job="hello-devops"} |= "Hello from container to Loki"' \
  --data-urlencode 'limit=100'

7. Monitoring Flow
``` text
Docker container
      |
      | container logs
      v
Grafana Alloy
      |
      | Loki API
      v
Grafana Loki
```
:wq!


Check your monitoring files

Run:
ls -l monitoring/

should have:

alloy-config.alloy
loki_setup.txt

Commit monitoring

Run:

git add monitoring/

Then:

git commit -m "Add Grafana Loki monitoring configuration"


Then:

git push

IF you make changes in README.md after that save it ,press command+s then,
git status
git add README.md
git commit -m "Update README"
git push origin main
git status





