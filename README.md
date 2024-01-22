# Terraform - Step 1

What is Terraform?

Its IaaC (Infrastructure As a Code) and Automates Infrastructure

Defines Infrastructure state and machine state

Terraform automates Infrastructure itself.

After setup with Terraform you can work with automation softwares like Ansible, or manuel with bash/python scripting.

There is no need for programming, it has its own syntax which is similar to JSON files.

You just declare how its done/execute .tf files.

Terraform provides centralized automation and can be used variety of clouds(AWS,Azure,Google Cloud) with a bit of syntax difference. (like Image id/name, region and subnet name, attributes).

Configuration AWS environment

At first we created a user in AWS with Administrator Access as policy. Then use method via CLI. Opened Git-bash (whatever fit for you), AWS configure – write Access KEY ID and Access Secret Key ( not recommending but this is step by step learning so we continue this way but remember best practice is use IAM Roles).

![](RackMultipart20240122-1-jue95q_html_86e952548ba9955c.png)

After we created folders which contains terraform files, we opened it with visual code studio(whatever suits for you).

![](RackMultipart20240122-1-jue95q_html_5af4c59515de8e3f.png)

![](RackMultipart20240122-1-jue95q_html_6dcd3779cd481fe5.png)

After write our first .tf file; we declared region, AMI Id, availability zone, key name, security group id and tag for EC2 instance this is how it looks.

![](RackMultipart20240122-1-jue95q_html_d9b86c866640c713.png)

After that switch to Bash command, and command \>terraform init so it will check our declarative file which is my\_instance.tf. And \>terraform validate check syntax errors etc. Then you can also \>terraform fmt which is reformat your file as align changes and smoother view.

![](RackMultipart20240122-1-jue95q_html_e79a63151b02859e.png)

After \>terraform plan it shows you whats gonna be created and applied. As you can see at bottom it says; 1 to add 0 to change 0 to destroy. If we had already built terraform it'll change if it could, otherwise it'll destroy and then -recreate.(For example if we change EC2 type).

![](RackMultipart20240122-1-jue95q_html_832e55507b61d5ec.png)

After \>terraform apply it'll build up EC2 instance as we declared.

![](RackMultipart20240122-1-jue95q_html_a30a8ecad7d5dd09.png)

![](RackMultipart20240122-1-jue95q_html_18b95f38d180d1ba.png)

![](RackMultipart20240122-1-jue95q_html_c4a4c596cd4aae11.png)

![](RackMultipart20240122-1-jue95q_html_55d28463cf775c38.png)

Lastly with only 1 command \>terraform destroy , it'll destroy any resource we created. And this show how powerful cloud + terraform combination. And dont worry I already deleted all related account and credentials that i show you. :)

# Terraform - Step 2

Now we will go a bit advance and split terraform my\_instance to 3 parts which are providers, instance, vars.tf .To reminder it was look like this:

![](RackMultipart20240122-1-jue95q_html_d9b86c866640c713.png)

Whats the reason of it ?

We created 3 variables in vars.tf which are REGION, ZONE, AMI . This file (vars.tf) defines the variables (REGION, ZONE1, and AMIS) used in the main configuration. The AMIS variable is a map of AWS region codes to AMI IDs.

![](RackMultipart20240122-1-jue95q_html_2bb3905e386fcf15.png)

providers.tf specifies the AWS provider configuration using the variables defined in vars.tf. It sets the region dynamically based on the value of the REGION variable.

![](RackMultipart20240122-1-jue95q_html_f5b5e61435572a04.png)

instance.tf declares another AWS EC2 instance resource named "terraform\_step2." And it uses the variables defined in vars.tf to set the AMI, instance type, availability zone, etc.

![](RackMultipart20240122-1-jue95q_html_2bed3286183b1a97.png)

By splitting our configuration into these separate files, we make it more modular and easier to manage. Each file has a specific purpose, and changes to one part of the infrastructure can be isolated to the relevant file.

Now we are ready, We will repeat the same process like the first step.

\>terraform init so it will check our declarative files. And \>terraform validate check syntax errors etc. ![](RackMultipart20240122-1-jue95q_html_50ae8a13a6279838.png)

After \>terraform plan it shows you whats gonna be created and applied. As you can see at bottom it says; 1 to add 0 to change 0 to destroy. If we had already built terraform it'll changes if it could otherwise it'll destroy then -recreate.(For example if we change the EC2 type or key pairs we used).

![](RackMultipart20240122-1-jue95q_html_996025c02542e7f6.png)

After \>terraform apply it'll build up EC2 instance as we declared.

![](RackMultipart20240122-1-jue95q_html_7be66358ba759bfd.png)

You can see what we declared in aws:

![](RackMultipart20240122-1-jue95q_html_7ffe92d8b2f3bc92.png)

![](RackMultipart20240122-1-jue95q_html_8f4ac57d057a2ec1.png)

\>terraform destroy , it'll destroy any resource we created. And this show how powerful cloud + terraform combination.

![](RackMultipart20240122-1-jue95q_html_7a10b5b296e27e4c.png)

AWS console:

![](RackMultipart20240122-1-jue95q_html_7da0fc34c5103ff.png)

# Terraform - Step 3

We'll provision with Terraform based on OS, we have to declare connection type, user and password. Then push a file to instance, and remote execute the script that we created. There are a lot of methods to do this task, but this is a terraform journey so stick with it.

First we'll generate a key pair in our local machine instead of manual task of using aws console.

Write a script named web.sh to execute.

Then create providers, vars, instance.tf

Basically, key pair resources, aws\_instance resource, then provisioners to push file then remote execute to execute these files.

Lets start;

We are in practice folder, and generating key-pairs

![](RackMultipart20240122-1-jue95q_html_e5c6065977ff4f98.png)

Then we created, instance.tf, providers.tf vars.tf and web.sh lets look at them one by one.

**instance.tf:**

aws\_key\_pair: Defines an AWS key pair resource. It creates an SSH key pair named "terra-key3" with the public key loaded from the file "terra-key3.pub." that we created.

aws\_instance: Defines an AWS EC2 instance resource. It uses the specified AMI, instance type, availability zone, key pair, security group, and tags. Additionally, it includes two provisioners:

file provisioner: Copies the local script "web.sh" to the "/tmp/web.sh" path on the remote EC2 instance.

remote-exec provisioner: Executes commands on the remote instance to make the script executable and then runs it with elevated privileges.chmod giving permission and sudo command provides privileges.

![](RackMultipart20240122-1-jue95q_html_ca373d768b2b7f55.png)

**providers.tf:**

provider "aws": Specifies the AWS provider with the specified region, which is set as a variable.

![](RackMultipart20240122-1-jue95q_html_10aaf92ec48f72fb.png)

**vars.tf:**

Defines variables used in the configuration:

REGION: Specifies the default AWS region as "us-east-2."

ZONE1: Specifies the default availability zone within the region as "us-east-2a."

AMIS: Specifies a map of AWS regions to corresponding AMI IDs for different regions.

USER: Specifies the default username ("ec2-user") used for connecting to the EC2 instance.

![](RackMultipart20240122-1-jue95q_html_8e5a97a75d6b2b84.png)

**web.sh** :

A Bash script that performs the following tasks:

Installs necessary packages (yum install wget unzip httpd -y).

Starts the Apache web server (systemctl start httpd).

Enables the Apache service to start on boot (systemctl enable httpd).

Downloads a ZIP file from a specific URL using wget.

Unzips the downloaded file.

Copies the contents of the unzipped directory to the "/var/www/html/" directory.

Restarts the Apache server to apply changes (systemctl restart httpd).

![](RackMultipart20240122-1-jue95q_html_dbf4f230bc45716b.png)

Together, these files build an AWS infrastructure using Terraform; this includes defining variables, creating an EC2 instance, configuring AWS provider settings, and running a script to install a web server on the EC2 instance. Web content is downloaded and deployed by the web server script from a given URL.

Lets see results;

So we building up..

\>terraform init for initializes a Terraform working directory by downloading and configuring the necessary providers and modules, \>terraform validate for check the syntax and validity of the Terraform files, \>terraform fmt for automatically formats Terraform configuration files to adhere to a consistent style

![](RackMultipart20240122-1-jue95q_html_19d6c729cd145efe.png)

\>terraform plan generates an execution plan.

![](RackMultipart20240122-1-jue95q_html_596346261d329546.png)

![](RackMultipart20240122-1-jue95q_html_749d81a532caf774.png)

\>terraform apply applies the changes outlined in the execution plan to the infrastructure.

![](RackMultipart20240122-1-jue95q_html_48ca9cde81e43064.png)

Lets review on aws console;

![](RackMultipart20240122-1-jue95q_html_8783ce0b4b6ea5de.png)

![](RackMultipart20240122-1-jue95q_html_ac7256d3b35258ef.png)

And this is output;

![](RackMultipart20240122-1-jue95q_html_fb2f553508ab0568.png)

**Appreciate your time in reviewing this. Thank you!**