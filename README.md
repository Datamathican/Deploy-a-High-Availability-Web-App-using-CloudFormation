# Udagram: Deploy a High-Availability Web App using CloudFormation

**Author:** Pramod Singh  
**Date:** 10-03-2026

---

## Project Overview
This project automates the deployment of a high-availability web application using **AWS CloudFormation**. The infrastructure is designed to be resilient, secure, and scalable, following AWS best practices. The application is hosted on Ubuntu servers within a private network and is accessible via an Application Load Balancer.

---

## Architecture Diagram
The following diagram illustrates the cloud infrastructure, including the VPC, public/private subnets, NAT Gateways, Load Balancers, and the Auto Scaling Group.



---

## Infrastructure Components

### 1. Network Layer (`network.yml`)
* **VPC:** A Virtual Private Cloud with a custom CIDR block.
* **Subnets:** 4 Subnets (2 Public and 2 Private) spread across two Availability Zones for high availability.
* **Internet Gateway:** Provides internet access for public subnets.
* **NAT Gateways:** Two NAT Gateways (one in each AZ) to allow private instances to access the internet for updates while remaining inaccessible from the outside.

### 2. Application Layer (`udagram.yml`)
* **Launch Template:** Configured with **Ubuntu 22.04 LTS**, **t2.micro** instance type, and a **10GB** EBS volume.
* **Auto Scaling Group (ASG):** Maintains a minimum of **4 EC2 instances** across two private subnets.
* **Application Load Balancer (ALB):** Distributed across public subnets to route traffic to the private EC2 instances.
* **Security Groups:** * **ALB Security Group:** Allows Port 80 (HTTP) from anywhere (0.0.0.0/0).
    * **Web Server Security Group:** Only allows Port 80 (HTTP) traffic coming specifically from the Load Balancer.
* **IAM Role:** An Instance Profile allowing EC2 instances read-only access to S3.

### 3. Bonus Content (Static Web & CDN)
* **S3 Bucket:** Used to store static web assets.
* **CloudFront Distribution:** A Content Delivery Network (CDN) to serve the static content with low latency.

---

## Getting Started

### Prerequisites
* An active AWS Account.
* AWS CLI installed and configured.
* A terminal/command prompt (AWS CloudShell is recommended).

### Deployment Steps
1. **Clone the Repository:**
   ```bash
   git clone <your-repo-link>
   cd <your-repo-folder>

2. **Deploy the Network Stack:**

Bash
./create.sh UdagramNetwork infrastructure/network.yml infrastructure/network-parameters.json
Wait for the status to show CREATE_COMPLETE in the CloudFormation Console.

**Deploy the Application Stack:**

Bash
./create.sh UdagramApp infrastructure/udagram.yml infrastructure/udagram-parameters.json
Access the Application:
Once the stack is complete, go to the Outputs tab of the UdagramApp stack in the AWS Console and click the LoadBalancerURL.

Files in this Repository
infrastructure/network.yml: CloudFormation template for the VPC and networking.

infrastructure/udagram.yml: CloudFormation template for servers, load balancers, and security.

infrastructure/*.json: Parameter files for environment customization.

create.sh: Shell script to automate stack creation.

delete.sh: Shell script to automate stack deletion.

Architecture_Diagram.png: Visual representation of the cloud resources.

**Clean Up**
To avoid ongoing AWS charges, delete the stacks in the following order:

Bash
# Delete the app first
./delete.sh UdagramApp

# Delete the network last
./delete.sh UdagramNetwork

**License**
This project is part of the Udacity AWS Cloud DevOps Engineer Nanodegree.
