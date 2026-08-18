DevOps Intern Final Assessment

Name: Jiss Varghese
Date: 18 August 2026
Repository: devops-intern-final

Project Overview

This project demonstrates a complete DevOps workflow using open-source tools and practices.

The workflow covers:

Git & GitHub
Linux & Bash Scripting
Docker
CI/CD with GitHub Actions
Container Deployment with Nomad
Monitoring with Grafana Loki and Grafana Alloy

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
Project Structure

The final repository is  containing  the following structure:

devops-intern-final/
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

Step 1 — Git & GitHub Setup


Create a public GitHub repository and initialize the project 

Repository

Repository name:

devops-intern-final

The repository is public and contains all project source code, configuration files, documentation, and screenshots.

Application

The sample Python application is stored in:

hello.py

The application prints:

Hello, DevOps!

Run the Application
python3 hello.py

Output:
Hello, DevOps!

Git Commands Used
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin <https://github.com/Jiss-Varghese/devops-intern-final.git>
git push -u origin main
Output
Public GitHub repository created
README.md added
hello.py added
Initial Git commit pushed to GitHub

git remote add origin https://github.com/Jiss-Varghese/devops-intern-final.git
git remote -v
git add README.md hello.py
git commit -m "Add initial project files"
git branch -M main
git push -u origin main


Linux & Scripting Basics

Create a Bash script that displays basic system information.

The script is located at:

scripts/sysinfo.sh

The script displays:

Current username
Current date and time
Disk usage
Make the Script Executable
chmod +x scripts/sysinfo.sh

Run the Script
./scripts/sysinfo.sh

The script uses Linux/macOS commands such as:

whoami
date
df -h
 Output
User:
jiss

Date:
Mon Aug 18 19:00:00 SGT 2026

Disk Usage:
Filesystem      Size   Used  Avail Capacity
...
Output
Bash system-information script created
Script made executable
System information successfully displayed

Docker Basics


Containerize the Python application using Docker.

The Docker configuration is stored in:

Dockerfile
Dockerfile

The Docker image uses Python as its base image and runs hello.py.

Build the Docker Image

From the project root:

docker build -t hello-devops .

Check the image:

docker images
Run the Container
docker run --rm hello-devops

 output:

Hello, DevOps!
Useful Docker Commands

Check running containers:

docker ps

Check all containers:

docker ps -a

Check images:

docker images

Remove an image:

docker rmi hello-devops
Output
Dockerfile created
Docker image successfully built
Python application successfully executed inside a container