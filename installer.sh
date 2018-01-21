#!/bin/sh

sudo yum update -y
sudo yum install -y httpd24 php70 mysql56-server php70-mysqlnd

#Start the Apache web server
sudo service httpd start

#chkconfig command to configure the Apache web server to start at each system boot.
sudo chkconfig httpd on

#verify that httpd is on by running the following command
chkconfig --list httpd

ls -l /var/www
sudo usermod -a -G apache ec2-user
groups
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

#Create a PHP file in the Apache document root
[ec2-user ~]$ echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

#mySQL 
sudo service mysqld start
sudo mysql_secure_installation
sudo chkconfig mysqld on

#Install phpMyAdmin
#Install the required dependencies
sudo yum install php70-mbstring.x86_64 php70-zip.x86_64 -y

#Restart Apache
sudo service httpd restart

#Navigate to the Apache document root at /var/www/html
#cd /var/www/html

#wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
#tar -xvzf phpMyAdmin-latest-all-languages.tar.gz
#mv phpMyAdmin-4.7.5-all-languages phpMyAdmin
#sudo service mysqld start
