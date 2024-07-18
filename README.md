# Terraform Cloud Run Deployment

## Overview
This repository contains Terraform code to deploy a "Hello World" application on Google Cloud Run with appropriate security considerations and dynamic deployment configurations for multiple environments.

## Requirements
- Google Cloud Platform account
- Terraform installed on the local machine
- gcloud CLI installed on the local machine

## Setup
1. Clone the repository:
    ```sh
    git clone https://github.com/your-username/terraform-cloud-run.git
    cd terraform-cloud-run
    ```

2. Enable the required Google Cloud APIs:
    ```sh
    gcloud services enable run.googleapis.com
    gcloud services enable iam.googleapis.com
    gcloud services enable cloudresourcemanager.googleapis.com
    gcloud services enable compute.googleapis.com
    gcloud services enable serviceusage.googleapis.com
    ```

3. Authenticate with GCP and set up Application Default Credentials:
    ```sh
    gcloud auth login
    gcloud config set project YOUR_PROJECT_ID
    gcloud auth application-default login
    ```

4. Navigate to the desired environment directory and initialize Terraform:
    ```sh
    cd environments/dev
    terraform init
    ```

5. Apply the Terraform configuration:
    ```sh
    terraform apply
    ```

6. Verify the Outputs:
    - Cloud Run URL
    - Invoker Service Account Email

7. Test the Cloud Run Service:
    - Open a web browser and navigate to the Cloud Run URL. You should see the "Hello World" message.

## Clean Up
To avoid unnecessary costs, destroy the Terraform-managed infrastructure after testing:
```sh
cd environments/dev
terraform destroy
