 C++ CI/CD Pipeline using GitHub Actions + Docker
 Project Overview

This project demonstrates a complete CI/CD pipeline for a minimal C++ application using:
✅ CMake
✅ GoogleTest (Unit Testing)
✅ GitHub Actions (CI + CD)
✅ Docker
✅ DockerHub (Image Registry)
✅ GitHub Secrets (Secure Credentials)
✅ Branch Protection Rules

The goal was to simulate an industry-level workflow from code commit to Docker image deployment.
🧱 Step 1 — Created Minimal C++ Application
Project structure:
cpp-cicd-app/
├── src/
├── include/
├── tests/
├── CMakeLists.txt
├── Dockerfile
└── .github/workflows/


Features:
Simple add() function
Unit tests using GoogleTest
CMake-based build system

🐙 Step 2 — Push to GitHub
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/<username>/cpp-cicd-app.git
git push -u origin main


🔀 Step 3 — Feature Branch Workflow
git checkout -b feature/test-pipeline
git push origin feature/test-pipeline


Created Pull Request → CI triggered automatically.

⚙️ Step 4 — Continuous Integration (CI)
Created:
.github/workflows/integration.yml


Triggered on:
pull_request → main branch

CI Pipeline Steps:
Checkout code
Install dependencies
Build project using CMake
Run unit tests using ctest
If tests fail ❌ → Merge blocked
If tests pass ✅ → PR can be merged


🔐 Step 5 — Branch Protection Rule
GitHub → Settings → Branches → Add Rule

Protected main branch with:
✅ Require pull request before merging
✅ Require status checks to pass
✅ Selected CI pipeline check
✅ Prevent direct pushes to main

Now merge allowed only if:
✔ Build successful
✔ Tests successful

Step 6 — Continuous Deployment (CD)

Created:
.github/workflows/deploy.yml
Triggered on:
push → main branch

CD Pipeline Steps:

Checkout code
Login to DockerHub
Build Docker image
Push image to DockerHub

🐳 Step 7 — DockerHub Setup
Created DockerHub Account
https://hub.docker.com
Generated Access Token
DockerHub → Account Settings → Security → Access Tokens

Created token with:
Read & Write permissions

🔑 Step 8 — GitHub Secrets
GitHub → Repo → Settings → Secrets → Actions
Added:

Secret Name	Value
DOCKER_USERNAME	DockerHub username
DOCKER_PASSWORD	DockerHub Access Token

⚠ Used token instead of password (best practice)

🐳 Step 9 — Image Naming Convention
Image built as:
<docker_username>/cpp-cicd-app:latest

Example:
docker build -t priyanshu123/cpp-cicd-app:latest .
Namespace required for DockerHub push.

🧪 Step 10 — Verified Deployment
Checked GitHub Actions

Actions tab → CD Pipeline → All steps green ✅

Checked DockerHub

Repository → Tags → latest visible

Pulled & Ran from WSL
docker pull <username>/cpp-cicd-app:latest
docker run --rm <username>/cpp-cicd-app:latest


Output:

2 + 3 = 5

🧠 Final Workflow Architecture
Feature Branch
     ↓
Pull Request
     ↓
CI Pipeline (Build + Test)
     ↓
Merge to Main
     ↓
CD Pipeline (Docker Build + Push)
     ↓
DockerHub
     ↓
Pull & Run Anywhere

🏆 What This Project Demonstrates

Real CI/CD workflow

Secure secret handling

Branch protection enforcement

Automated Docker builds

Registry integration

Industry-standard DevOps practices

💡 Key Learnings

Difference between CI and CD

How to block merges using status checks

How GitHub Actions works

Why DockerHub tokens are required

How to automate Docker image publishing

How to verify remote deployments

🎯 Result

Successfully built an end-to-end automated CI/CD pipeline for a C++ application using GitHub Actions and DockerHub, fully deployable and runnable from any environment.
