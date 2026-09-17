# DevOps Intern Final Assessment

GitHub Actions badge

[CI] 

https://github.com/Jiss-Varghese/devops-intern-final/actions/workflows/ci.yml/badge.svg

https://github.com/Jiss-Varghese/devops-intern-final/actions/workflows/ci.yml


**Name:** Jiss Varghese  
**Date:** September 17, 2026

## Project Description

This project demonstrates a basic DevOps workflow using Git, GitHub, Linux shell scripting, Docker, GitHub Actions, Nomad, and Grafana Loki.

The project starts with a simple Python application and progressively packages, tests, deploys, and monitors it.

## Project Structure

```text
devops-intern-final/
├── .github/
│   └── workflows/
│       └── ci.yml
├── monitoring/
│   └── loki_setup.txt
├── nomad/
│   └── hello.nomad
├── scripts/
│   └── sysinfo.sh
├── Dockerfile
├── hello.py
└── README.md
```

Create the GitHub repository<br>
Name: devops-intern-final<br>
 make it public<br>
STEP 1 — Git & GitHub Setup

git --version<br>
python3 --version<br>
Create the project directory<br>
cd ~<br>
mkdir devops-intern-final<br>
cd devops-intern-final<br>
pwd<br>
Initialize Git<br>
git init<br>
ls -la<br>
Create hello.py<br>
code hello.py<br>
   print("Hello, DevOps!")

Test Python<br>
 python3 hello.py<br>
Output: Hello, DevOps!    (Screenshot attached-Python Output)

Create the initial README
touch README.md
code README.md

Check Git status
git status
git add README.md hello.py
git add .
git commit -m "Initial project setup"

Connect local Git to GitHub

git remote add origin https://github.com/Jiss-Varghese/devops-intern-final.git

git remote -v
git branch -M main
git push -u origin main
git push
code .  (Entire project open in vscode)

Step 2 — Linux & Shell Scripting

mkdir scripts
touch scripts/sysinfo.sh
code  scripts/sysinfo.sh
  #!/bin/bash

echo "Current user:"
whoami

echo "Current date:"
date

echo "Disk usage:"
df -h

Make the script executable
chmod +x scripts/sysinfo.sh
ls -l scripts/sysinfo.sh
./scripts/sysinfo.sh

Output: (Screenshot attached-Linux Output)

git add scripts/sysinfo.sh
git commit -m "Add Linux system information script"
git push

Step 3 — Docker

docker --version
touch Dockerfile

code Dockerfile

 FROM python:3.12-slim

WORKDIR /app

COPY hello.py .

CMD ["python", "hello.py"]

Build the Docker image

docker build -t hello-devops:latest .

Check image
docker images
Run the container
docker run --rm hello-devops:latest
Output: Hello, DevOps!  (Screenshot attached-Docker Output)
Why --rm?
means Docker automatically removes the container after it exits.
Check containers

docker ps 
 This shows only currently running containers 
 To see stopped containers:

 docker ps -a
Commit Docker

git add Dockerfile
git commit -m "Add Docker containerization"
git push
git status

Step 4 — GitHub Actions CI/CD
Now we automatically test the Python program whenever code is pushed.

Create the directories:
mkdir -p .github/workflows
touch .github/workflows/ci.yml
code .github/workflows/ci.yml
  
  name: CI

on:
  push:

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.12"

      - name: Run application
        run: python hello.py
Commit and push CI

git add .github/workflows/ci.yml README.md
git commit -m "Add GitHub Actions CI workflow"
git push

Step 5 — Nomad

Nomad is a workload orchestrator.

In simple terms, it can manage and run applications/jobs.

Here we're going to tell Nomad:

Run my Docker container as a service.

The flow becomes:

```text
Docker image
      ↓
Nomad job
      ↓
Nomad allocation
      ↓
Docker container

```

nomad version
which nomad

Docker image availability

Nomad needs to be able to obtain the Docker image

If your Nomad job says:
hello-devops:latest
but the Nomad environment cannot access that local image

A reliable local setup is to use a local Docker registry.

Start a local Docker registry

docker ps
docker run -d --name local-registry -p 5001:5000 registry:2
Tag the image

Create a registry tag:
docker tag hello-devops:latest localhost:5001/hello-devops:latest

docker images

Push the image
docker push localhost:5001/hello-devops:latest
This uploads the image to your local registry.

Now we deploy the Docker container using Nomad

Create the Nomad directory

mkdir -p nomad

touch nomad/hello.nomad
code nomad/hello.nomad
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
        args = ["-u", "-c", "import time; print('Hello, DevOps!', flush=True); time.sleep(3600)"]
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}

Validate the job

nomad job validate nomad/hello.nomad

Output: Job validation successful

Start a local Nomad agent

nomad agent -dev

keep the Terminal window open 
And Open another Terminal window and
Check Nomad
nomad node status

Run the job
nomad job run nomad/hello.nomad
Check the job status
nomad job status hello-devops

Check the allocation logs
nomad job allocations hello-devops
nomad alloc status c03e952a

view logs
nomad alloc logs c03e952a
  Output: Hello, DevOps!

git status
git add nomad/hello.nomad README.md
git commit -m "Add Nomad deployment configuration"
git push origin main
git push
git status

STEP 6 — Grafana Loki Monitoring

Grafana Loki is a log aggregation system.

Instead of having to look at logs individually on each container, you can send them to Loki and query them.

The basic flow is:

```text
Docker container
       ↓
Container logs
       ↓
Grafana Alloy
       ↓
Loki
       ↓
Log query

```

Why Alloy?

Grafana Alloy can collect logs and forward them to Loki.
Start Loki
docker pull grafana/loki:latest
docker run -d --name loki -p 3100:3100 grafana/loki:latest -config.file=/etc/loki/local-config.yaml

Output: ready
Create a test logging container
We need a container that continuously produces logs.

docker run -d --name hello-logs hello-devops:latest sh -c "echo 'Hello from container to Loki'; sleep 3600"

docker logs hello-logs

Output: Hello from container to Loki

Install/start Grafana Alloy

docker pull grafana/alloy:latest
Create the monitoring directory:
mkdir -p monitoring
code monitoring/alloy-config.alloy
  discovery.docker "containers" {
  host = "unix:///var/run/docker.sock"
}

discovery.relabel "containers" {
  targets = discovery.docker.containers.targets

  rule {
    source_labels = ["__meta_docker_container_name"]
    target_label  = "container"
    regex         = "/(.*)"
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

Start Alloy

docker run -d --name grafana-alloy -v "$(pwd)/monitoring/alloy-config.alloy:/etc/alloy/config.alloy" -v /var/run/docker.sock:/var/run/docker.sock -p 12345:12345 grafana/alloy:latest run /etc/alloy/config.alloy --server.http.listen-addr=0.0.0.0:12345

Check Alloy: docker ps

 should see:
 grafana-alloy
 loki
 hello-logs

Then check Alloy logs:

 docker logs grafana-alloy --tail 50

 Check Loki labels

 curl http://localhost:3100/loki/api/v1/labels

 should see

   ```text

   {
  "status": "success",
  "data": [
    "container",
    "job",
    "service_name"
  ]
}

```

Check job labels

curl http://localhost:3100/loki/api/v1/label/job/values

should see

```text
  {
  "status": "success",
  "data": [
    "hello-devops"
  ]
}

```

Query the logs

curl -G 'http://localhost:3100/loki/api/v1/query_range' \
  --data-urlencode 'query={job="hello-devops"} |= "Hello from container to Loki"' \
  --data-urlencode 'limit=20'


Output: Hello from container to Loki (Screenshot attached)
Create loki_setup.txt
touch monitoring/loki_setup.txt
code monitoring/loki_setup.txt
  ```text

  Grafana Loki Monitoring Setup
=============================

Purpose
-------
Grafana Loki is used to collect and query logs generated by Docker containers.

1. Start Loki
-------------

The Loki Docker image was started with:

docker run -d \
  --name loki \
  -p 3100:3100 \
  grafana/loki:latest \
  -config.file=/etc/loki/local-config.yaml

Loki is exposed on port 3100.

2. Start the test logging container
-----------------------------------

docker run -d \
  --name hello-logs \
  hello-devops:latest \
  sh -c "echo 'Hello from container to Loki'; sleep 3600"

The container generates the test log:

Hello from container to Loki

3. Start Grafana Alloy
----------------------

Grafana Alloy is used to discover Docker containers, collect their logs, and forward the logs to Loki.

The Alloy configuration is stored in:

monitoring/alloy-config.alloy

4. Check container logs
-----------------------

docker logs hello-logs

5. Check Loki readiness
-----------------------

curl http://localhost:3100/ready

Expected response:

ready

6. View Loki labels
-------------------

curl http://localhost:3100/loki/api/v1/labels

7. View job label values
-----------------------

curl http://localhost:3100/loki/api/v1/label/job/values

8. Query logs
-------------

curl -G 'http://localhost:3100/loki/api/v1/query_range' \
  --data-urlencode 'query={job="hello-devops"} |= "Hello from container to Loki"' \
  --data-urlencode 'limit=20'

The query searches Loki for logs from the hello-devops job containing:

Hello from container to Loki

```
git add monitoring/ README.md
git commit -m "Add Loki monitoring configuration"
git push
