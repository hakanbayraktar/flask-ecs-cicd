# 🚀 Flask App Deployment to AWS ECS (Fargate) with GitHub Actions & Bash Scripts

This repository demonstrates how to deploy a Flask application to AWS ECS Fargate in two ways:

1. ✅ **Manual deployment using GitHub Actions and AWS Console** – Ideal for learning and step-by-step configuration.
2. ✅ **Fully automated deployment and teardown using Bash scripts** – For rapid, repeatable, and local terminal-driven workflows.

Full explanation for the manual GitHub Actions approach is available in the accompanying Medium article:
👉 [📘 Automating Deployment of a Flask Application to AWS ECS with GitHub Actions](https://hbayraktar.medium.com/automating-deployment-of-a-flask-application-to-aws-ecs-with-github-actions-c256192eb8ad)

---

## 📁 Project Structure

```bash
.
├── .github/workflows/
│   └── deploy.yaml        # GitHub Actions workflow file
├── app/
│   └── app.py            # Flask application code
├── Dockerfile            # Flask app Docker build config
├── requirements.txt      # Python dependencies
├── ecs-setup.sh          # Script to deploy infrastructure and the app
├── ecs-cleanup.sh        # Script to clean up all AWS resources
└── README.md             # Project documentation
```

---

## 📦 What This Project Does

This project demonstrates how to:

- Containerize a Python Flask app using Docker
- Push the Docker image to AWS ECR
- Deploy the container on AWS ECS Fargate
- Automate deployment using GitHub Actions
- Clean up all AWS resources when no longer needed

You can choose between manual deployment (GitHub Actions + AWS Console) or fully automated Bash scripts.

---

## 🛠 Step-by-Step Manual Setup with GitHub Actions

To manually deploy your Flask app to ECS using GitHub Actions:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/hakanbayraktar/flask-ecs-cicd.git
   cd flask-ecs-cicd
   ```
2. **Create an IAM user** in AWS with programmatic access and attach ECR/ECS permissions.
3. **Configure GitHub Secrets** in your repo:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_REGION`
   - `ECR_REPOSITORY`
4. **Create ECR repository**:
   ```bash
   aws ecr create-repository --repository-name flask-ecr-repo
   ```
5. **Create ECS Cluster**:
   ```bash
   aws ecs create-cluster --cluster-name flask-cluster
   ```
6. **Modify `.github/workflows/deploy.yaml`** to match your repo and service setup.
7. **Push your code to GitHub**. GitHub Actions will automatically build, push, and deploy your app.

> 💡 **Test your deployment:** You can verify that GitHub Actions successfully redeploys your app by modifying the message inside `app/app.py`. For example, change the text returned by the route, commit, and push. ECS will redeploy and reflect your update.

👉 For detailed explanation and screenshots, refer to the [Medium article](https://hbayraktar.medium.com/automating-deployment-of-a-flask-application-to-aws-ecs-with-github-actions-c256192eb8ad).

---

## ⚙️ Option 1 – Fully Automated Deployment via Bash Script

To skip all manual steps and deploy automatically:

### ✅ Run the deployment script:
```bash
chmod +x ecs-setup.sh
./ecs-setup.sh
```

This script will:
- Detect your AWS default VPC and subnet
- Create or reuse a Security Group
- Create IAM role `ecsTaskExecutionRole` if missing
- Create the ECR repository
- Build and push Docker image for `linux/amd64`
- Register Task Definition
- Create ECS Cluster and Service
- Force ECS deployment using latest image

Once completed, your Flask app will be live on ECS Fargate.

---

## 🧹 Option 2 – Fully Automated Cleanup Script

Once your testing is complete and you no longer need the resources, you can clean everything up:

### ✅ Run the cleanup script:
```bash
chmod +x ecs-cleanup.sh
./ecs-cleanup.sh
```

This script will:
- Stop all running ECS Tasks
- Delete ECS Service and Cluster
- Deregister Task Definitions
- Delete ECR Repository
- Delete Security Group

> ⚠️ This will permanently delete your AWS infrastructure. Use only after confirming tests.

---

## 📚 Medium Article Reference

For full manual instructions and GitHub Actions integration, read the article:

📘 [Automating Deployment of a Flask Application to AWS ECS with GitHub Actions](https://hbayraktar.medium.com/automating-deployment-of-a-flask-application-to-aws-ecs-with-github-actions-c256192eb8ad)

It covers:
- IAM setup
- GitHub Secrets configuration
- Manual ECR and ECS configuration
- YAML GitHub Actions CI/CD workflow

---

## 🧠 Notes

- Scripts tested on macOS (Intel & M1/M2), Linux, and AWS ECS Fargate `us-east-1`
- Docker images built with `buildx` and `linux/amd64` platform for Fargate compatibility
- This repo is great for learning DevOps pipelines, AWS deployment, and cloud automation

---

Happy deploying! ☁️🐳
