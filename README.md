# 🚀 C++ CI/CD Pipeline using GitHub Actions + Docker

## 📌 Project Overview

This project demonstrates a complete end-to-end CI/CD pipeline for a minimal C++ application using modern DevOps practices.

The goal is to simulate an industry-level workflow from code commit → automated testing → Docker image deployment.

---

## 🔧 Tech Stack

- CMake
- GoogleTest (Unit Testing)
- GitHub Actions (CI + CD)
- Docker
- DockerHub (Image Registry)
- GitHub Secrets (Secure Credentials)
- Branch Protection Rules

---

## 🏗️ Project Structure

```
cpp-cicd-app/
├── src/
├── include/
├── tests/
├── CMakeLists.txt
├── Dockerfile
└── .github/workflows/
```

---

## 🧱 Step 1 — Minimal C++ Application

### Features

- Simple `add()` function
- Unit tests using GoogleTest
- CMake-based build system

---

## 🐙 Step 2 — Push to GitHub

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/<username>/cpp-cicd-app.git
git push -u origin main
```

---

## 🔀 Step 3 — Feature Branch Workflow

```bash
git checkout -b feature/test-pipeline
git push origin feature/test-pipeline
```

Created a Pull Request → CI triggered automatically.

---

## ⚙️ Step 4 — Continuous Integration (CI)

Workflow file:

```
.github/workflows/integration.yml
```

### Trigger

- pull_request → main branch

### CI Pipeline Steps

1. Checkout code  
2. Install dependencies  
3. Build project using CMake  
4. Run unit tests using `ctest`  

### Merge Rules

- If tests fail → Merge blocked  
- If tests pass → PR can be merged  

---

## 🔐 Step 5 — Branch Protection Rules

Enabled on `main` branch:

- Require pull request before merging  
- Require status checks to pass  
- Selected CI pipeline check  
- Prevent direct pushes to main  

Merge is allowed only if:

- Build successful  
- Tests successful  

---

## 🚀 Step 6 — Continuous Deployment (CD)

Workflow file:

```
.github/workflows/deploy.yml
```

### Trigger

- push → main branch

### CD Pipeline Steps

1. Checkout code  
2. Login to DockerHub  
3. Build Docker image  
4. Push image to DockerHub  

---

## 🐳 Step 7 — DockerHub Setup

- Created DockerHub Account  
- Generated Access Token (Read & Write permissions)  

Used access token instead of password (best practice).

---

## 🔑 Step 8 — GitHub Secrets

Configured in:

Repository → Settings → Secrets → Actions

| Secret Name      | Value                     |
|------------------|--------------------------|
| DOCKER_USERNAME  | DockerHub username       |
| DOCKER_PASSWORD  | DockerHub Access Token   |

---

## 🏷️ Step 9 — Docker Image Naming

Image format:

```
<docker_username>/cpp-cicd-app:latest
```

Example:

```bash
docker build -t priyanshu123/cpp-cicd-app:latest .
```

Namespace is required for DockerHub push.

---

## 🧪 Step 10 — Deployment Verification

### GitHub Actions

Actions tab → CD Pipeline → All steps green

### DockerHub

Repository → Tags → `latest` visible

### Pull & Run

```bash
docker pull <username>/cpp-cicd-app:latest
docker run --rm <username>/cpp-cicd-app:latest
```

Output:

```
2 + 3 = 5
```

---

## 🧠 Final Workflow Architecture

```
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
```

---

## 🏆 What This Project Demonstrates

- Real CI/CD workflow
- Secure secret handling
- Branch protection enforcement
- Automated Docker builds
- Registry integration
- Industry-standard DevOps practices

---

## 💡 Key Learnings

- Difference between CI and CD
- Blocking merges using status checks
- GitHub Actions workflow automation
- Secure DockerHub authentication using tokens
- Automated Docker image publishing
- Remote deployment verification

---

## 🎯 Result

Successfully built a fully automated CI/CD pipeline for a C++ application using GitHub Actions and DockerHub.

The application is:

- Automatically tested  
- Automatically containerized  
- Automatically published  
- Deployable from any environment  

---

#THE NEXT STEP IS TO REDUCE THE SIZE OF IMAGE THAT IS PUSHED ON DOCKERHUB BY USING MULTI STAGE DOCKER BUILD


# 🚀 Docker Image Size Optimization

## ❗ Why Was the Docker Image Large?

The previous Dockerfile produced a large image because:

- ❌ It kept build tools (`gcc`, `cmake`, `gtest`)
- ❌ It kept full source code
- ❌ It kept build artifacts
- ❌ Ubuntu base image itself is heavy (~77MB)
- ❌ `build-essential` adds ~300MB+

👉 Final image size was approximately **500–800MB**

---

## 🎯 Optimization Strategy

To reduce the image size, we applied:

- ✅ Multi-stage build
- ✅ Separate build & runtime environments
- ✅ Copy only compiled binary to runtime stage
- ✅ Use smaller runtime base image
- ✅ Added `.dockerignore` file

---

## 🧠 Architecture Change

### 🔴 Before (Single-Stage Dockerfile)

Everything was inside one stage:

- Build tools  
- Source code  
- Unit tests  
- Dependencies  
- Compiled binary  

This resulted in a heavy production image.

---

### 🟢 After (Multi-Stage Dockerfile)

We separated the build and runtime stages:

| Stage     | Contains                              |
|-----------|----------------------------------------|
| `builder` | gcc, cmake, gtest, source code        |
| `runtime` | Only compiled binary                  |

---

## 🎉 Final Runtime Image Contains

- ✔ No gcc  
- ✔ No cmake  
- ✔ No gtest  
- ✔ No source code  
- ✔ Only executable  

🚀 **Result: Massive image size reduction**

---

## 📦 Pull the Optimized Image

After a successful merge into the `main` branch,  
GitHub Actions automatically builds and pushes the optimized image to DockerHub.

Pull it using:

```bash
docker pull priyanshu6376/cpp-cicd-app:latest

