# DevOps Intern Final Assessment

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

Create the GitHub repository
Name: devops-intern-final
 make it public
STEP 1 — Git & GitHub Setup

git --version
python3 --version
Create the project directory
cd ~
mkdir devops-intern-final
cd devops-intern-final
pwd
Initialize Git
git init
ls -la
Create hello.py
code hello.py
   print("Hello, DevOps!")

Test Python
 python3 hello.py
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



