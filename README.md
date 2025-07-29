# TErraform-Webapp-Ansible-Palybook

						
Objective						
						
Use Terraform to provision an AWS EC2 instance and then use Ansible to configure and deploy a simple web app on it (e.g., install NGINX, push HTML file, start service).						
						
Challenge Steps						
						
1. Provision Infra using Terraform						
						
Launch a t2.micro EC2 instance in us-east-1						
Use appropriate key pair and security group for SSH and HTTP						
Use user_data to install python3 (Ansible needs it)						
						
2. Write Ansible Playbook						
						
From your local machine, use Ansible to:						
SSH into EC2 (use private key)						
Install and start NGINX						
Copy a custom index.html to /usr/share/nginx/html/index.html						
Ensure firewall (security group) allows access on port 80						
						
3. Test Deployment						
						
Hit the EC2 public IP in browser to confirm app is deployed						
						
	
