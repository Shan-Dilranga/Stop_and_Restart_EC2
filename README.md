# Stop_and_Restart_EC2
This repo is about the shell script that I used to automate the process of stop and restart AWS EC2

## Requirements for the Script to Work:
- Replace Placeholders:  
    - Replace your-instance-id with your EC2 instance's ID.  
    * Replace your-region with your AWS region (e.g., us-west-2).  
* Install AWS CLI (if not already installed):  
  **sudo apt update**  
  **sudo apt install awscli -y**
+ AWS CLI Setup: The AWS CLI must be installed and configured with valid credentials **(aws configure)**.  
- IAM Role/Permissions: The AWS CLI user or instance role needs the following permissions:  
  - ec2:StopInstances  
  * ec2:StartInstances  
  + ec2:DescribeInstanceStatus  
  - ec2:Wait
* Make the script file excutable  
  **sudo chmod 755 <file_name>.sh**
