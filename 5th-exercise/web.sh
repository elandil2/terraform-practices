#!/bin/bash
#Installs necessary packages 
yum install wget unzip httpd -y
#Starts the Apache web server
systemctl start httpd
#Enables the Apache service to start on boot
systemctl enable httpd
#Downloads a ZIP file from a specific URL using
wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
#Unzips the downloaded file
unzip -o 2117_infinite_loop.zip
#Copies the contents of the unzipped directory to the "/var/www/html/" directory.
cp -r 2117_infinite_loop/* /var/www/html/
#Restarts the Apache server to apply changes
systemctl restart httpd