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

Expected output:

Hello, DevOps!
Git Commands Used
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin <YOUR_GITHUB_REPOSITORY_URL>
git push -u origin main
Output
Public GitHub repository created
README.md added
hello.py added
Initial Git commit pushed to GitHub
