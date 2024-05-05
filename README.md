# Deployment of web Application on AWS EC2 Instances with Windows Server and Linux
The application should display a custom greeting message thatincludes the current server time. The application should log each request to a file or standard output, including the timestamp and the requested path.
## Overview
This manual guides how to deploy a **Hello World** web application built with ASP.NET core MVC on Amazon Web Services (AWS) EC2 instances using both Windows Server and Linux operating systems.This tutorial will walk you through the process of setting up your environment, configuring the servers, and deploying your application.
## Steps to Complete the Task:

1. **Create an ASP.NET MVC Web Application**

2. **Login to Your AWS Free Tier Account**

3. **Write Infrastructure as Code (IaC) in Terraform for Launching EC2 Instance**

4. **Connect Your Windows EC2 Instance to Remote Desktop Protocol (RDP) client**
   
5. **Deploy Your Application on IIS of AWS Windows Server**

6. **Connect to Your EC2 Linux Instance Using PuTTY**

7. **Deploy Your Web Application on EC2 Linux Instance**
### Step 1: Create an ASP.NET MVC Web Application

#### Prerequisites:
- Installation of Visual Studio (with ASP.NET workload)
- Basic understanding of ASP.NET MVC framework

#### Instructions:
1. **Open Visual Studio**: Launch Visual Studio on your development machine.
   
2. **Create a New Project**: Select "Create a new project" from the start page or go to File > New > Project.
   
3. **Choose ASP.NET Web Application**: In the "Create a new project" dialog, select "ASP.NET Web Application" from the list of project templates. Give your project a name and click "Create".
   
4. **Select MVC Template**: In the "Create a new ASP.NET Core Web Application" dialog, choose the "ASP.NET Core Web Application" template and select "MVC" as the project template. Click "Create".
   
5. **Run the Application**: Once the project is created, you can run it by pressing F5 or selecting Debug > Start Debugging from the menu.
   
6. **Customize the "Hello World" Application**:
   - Open the "HomeController.cs" file located in the "Controllers" folder.
   - Add a method to generate the custom greeting message including the current server time.
   - Update the corresponding view to display the greeting message.
   
7. **Implement Logging**:
   - Install a logging framework like Serilog or use the built-in logging capabilities of ASP.NET Core.
   - Configure logging to write each request to a file or standard output, including the timestamp and requested path.
   
8. **Test the Application**: Once you have made the necessary changes, run the application again to ensure that it works as expected. You should see the custom greeting message displayed on the webpage and the requests logged according to your configuration.

### Step 2: Login to Your AWS Free Tier Account

#### Prerequisites:
- Creation of a Free Tier AWS Account
  - Ensure that you have created a Free Tier AWS account. If you haven't already, you can sign up for an AWS Free Tier account [here](https://aws.amazon.com/free/).
- Creation of a User with Appropriate Permissions
  - Create a user with permissions to create and manage SQS queues, Lambda functions, and S3 buckets. Ensure that the user account has Multi-Factor Authentication (MFA) enabled for added security.

#### Instructions:
1. **Access the AWS Management Console**: Go to the [AWS Management Console](https://aws.amazon.com/console/) and sign in with your AWS account credentials.

2. **Verify Multi-Factor Authentication (MFA)**:
   - If you haven't already enabled MFA on your root account, do so to enhance the security of your AWS account.
   - Additionally, ensure that MFA is enabled for the user account you've created.

3. **Navigate to IAM (Identity and Access Management)**:
   - From the AWS Management Console, navigate to the IAM service by searching for "IAM" in the services search bar or selecting it from the list of available services.

4. **Create and Configure User**:
   - Create a user with the necessary permissions for managing SQS queues, Lambda functions, and S3 buckets.
   - Assign policies to the user granting permissions for the required AWS services.
   
5. **Enable MFA for User Account**:
   - Once the user is created, enable Multi-Factor Authentication (MFA) for the user account to add an extra layer of security.

6. **Access AWS Services**:
   - Once the user is set up with the appropriate permissions and MFA is enabled, you can now use this account to access AWS services for deploying and managing your applications.
### Step 3: Write Infrastructure as Code (IaC) in Terraform for Launching EC2 Instance

#### Prerequisites:
- Installation of Terraform on your local machine. You can download Terraform from the [official website](https://www.terraform.io/downloads.html) and follow the installation instructions for your operating system.

#### Instructions:
1. **Install Terraform**:
   - Download the appropriate Terraform binary for your operating system from the [official Terraform website](https://www.terraform.io/downloads.html).
   - Follow the installation instructions provided for your operating system to install Terraform on your local machine.
   - After installation, verify that Terraform is correctly installed by running `terraform --version` in your terminal or command prompt.

2. **Set Up Your Terraform Configuration File**:
   - Create a new directory for your Terraform project and navigate to it in your terminal or command prompt.
   - Inside the directory, create a new file named `main.tf`. This file will contain your Terraform configuration.
   - Open `main.tf` in a text editor of your choice.

3. **Write Terraform Configuration**:
   - Define your AWS provider and region in the `main.tf` file using Terraform syntax. For example:
     ```hcl
     provider "aws" {
       region = "us-east-1"
     }
     ```
   - Write Terraform code to define the resources you want to provision, such as an EC2 instance. Refer to the [Terraform documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) for guidance on configuring EC2 instances.

4. **Initialize Terraform Configuration**:
   - In your terminal or command prompt, navigate to the directory containing your Terraform configuration (`main.tf`).
   - Run `terraform init` to initialize the Terraform configuration. This command downloads any necessary plugins and sets up the directory for use with Terraform.

5. **Preview Terraform Changes**:
   - After initialization, run `terraform plan` to generate an execution plan. This command shows you what Terraform will do when you apply your configuration.
   - Review the plan to ensure it aligns with your expectations and makes any necessary adjustments to your Terraform configuration if needed.

6. **Apply Terraform Configuration**:
   - Once you're satisfied with the plan, apply the Terraform configuration by running `terraform apply`.
   - Terraform will prompt you to confirm the changes. Enter `yes` to proceed with applying the configuration.
   - Terraform will provision the resources defined in your configuration, including launching the EC2 instance on AWS.

7. **Verify Provisioned Resources**:
   - After Terraform has finished applying the configuration, verify that the EC2 instance was successfully launched by checking the AWS Management Console.
### Step 4: Connect Your Windows EC2 Instance to Remote Desktop Protocol (RDP) Client

#### Prerequisites:
- RDP client installed on your local machine (e.g., Remote Desktop Connection for Windows, Microsoft Remote Desktop for macOS).

#### Instructions:
1. **Retrieve EC2 Instance Public IP Address or DNS Name**:
   - Navigate to the EC2 dashboard and locate your Windows EC2 instance.
   - Note down the Public IPv4 address or Public DNS (IPv4) of the instance.

2. **Configure Security Group Rules**:
   - Ensure that the security group associated with your EC2 instance allows inbound traffic on port 3389 (RDP) from your IP address or a specific IP range.
   - If necessary, modify the security group rules to allow RDP traffic.

3. **Open Remote Desktop Connection (RDP) Client**:
   - Launch the Remote Desktop Connection application on your local machine. You can typically find it by searching for "Remote Desktop Connection" in the Start menu (Windows) or Spotlight (macOS).

4. **Enter EC2 Instance Details**:
   - In the Remote Desktop Connection window, enter the Public IP address or DNS name of your EC2 instance in the "Computer" field.
   - Click "Connect" to initiate the RDP connection.

5. **Enter Credentials**:
   - When prompted, enter the username and password for your Windows EC2 instance. These credentials can get by clicking GET PASSWORD of and uploading .Pem file of      key pair EC2 instance.

6. **Establish RDP Connection**:
   - After entering the correct credentials, click "OK" or "Connect" to establish the RDP connection to your Windows EC2 instance.

7. **Access Your Windows EC2 Instance**:
   - Once the RDP connection is established, you will have remote access to the desktop environment of your Windows EC2 instance.
   - follow the below steps to deploy your application.
### Step 5: Deploy Your Application on IIS of AWS Windows Server

#### Prerequisites:
- ASP.NET MVC web application project published and ready for deployment.
- Access to the Windows EC2 instance via Remote Desktop Protocol (RDP), as explained in Step 4.
- Administrative privileges on the Windows EC2 instance.

#### Instructions:
1. **Publish Your ASP.NET MVC Web Application**:
   - In Visual Studio, right-click on your ASP.NET MVC project and select "Publish".
   - Choose a publish target such as "Folder" or "File System", and specify a directory to publish the application files to.
   - Click "Publish" to generate the deployment package.

2. **Transfer Application Files to EC2 Instance**:
   - Now copy Your folder containing your web application And paste that on windows server
   - Place the files in a directory accessible to IIS, such as the default website directory (e.g., C:\inetpub\wwwroot).

3. **Configure Internet Information Services (IIS)**:
   - On the Windows EC2 instance, open Internet Information Services (IIS) Manager.
   - In the Connections pane, expand the server node, then expand Sites.
   - Right-click on the Default Web Site (or create a new site if desired) and select "Add Application".
   - Specify an alias for the application and the physical path to the directory containing your application files.
   - Configure additional settings such as the application pool and binding settings as needed.

4. **Configure Application Pool**:
   - In IIS Manager, navigate to Application Pools in the Connections pane.
   - Select the application pool associated with your application.
   - Ensure that the .NET CLR version and pipeline mode are configured correctly for your ASP.NET application.

5. **Grant Necessary Permissions**:
   - Ensure that the application pool identity (e.g., IIS AppPool\DefaultAppPool) has sufficient permissions to access the application files and any required       
     resources.
   - Grant permissions to the appropriate folders and files as needed.

6. **Test the Application**:
   - Once the application is deployed and configured in IIS, open a web browser and navigate to the URL of your EC2 instance.
   - If you encounter HTTP Error 500.19-Internal Server Error the refer this [HTTP Error 500.19](https://youtu.be/EatWfAKT078?si=HEfqrzvWthMJizGg) And Then
    [HTTP Error](https://youtu.be/XgpfAliJ-nw?si=jtpISmxxI8MosDE1)
   - Verify that the application loads successfully and functions as expected.






