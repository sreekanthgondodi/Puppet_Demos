# ****************************************** Scenario: Puppet Setup File Permissions ************************************************************

# The Nautilus DevOps team has put data on all app servers in Stratos DC. 
# jump host is configured as Puppet master server, and all app servers are already been configured as Puppet agent nodes. The team needs to update content of some of the exiting files as well as update its permissions, etc. Please find below more details about the task:

# Create a Puppet programming file news.pp under /etc/puppetlabs/code/environments/production/manifests directory on master node i.e Jump Server. Using puppet file resource, perform the below mentioned tasks.

# File ecommerce.txt already exists under /opt/security directory on App Server 2.

# Add content Welcome to xFusionCorp Industries! in file ecommerce.txt on App Server 2.

# Set permissions 0755 for file ecommerce.txt on App Server 2.

# Note: Please perform this task using news.pp only, do not create any separate inventory file.

# ----------------------------------------------------------------------------------------------------------------------------------

#1. Create file beta.pp at below path

# vi /etc/puppetlabs/code/environments/production/manifests/news.pp

class file_modifier {

	file { '/opt/security/ecommerce.txt':
      ensure => present,
	  content => 'Welcome to xFusionCorp Industries!',
	  mode => '0755',
    } 
}

node 'stapp02.stratos.xfusioncorp.com' {
include file_modifier
}

node 'default' {
}

# 2. Complile and test news.pp file   
# puppet parser validate news.pp 
# puppet apply news.pp  --noop

# 3. Apply/Execute the news.pp  file
# puppet apply news.pp 

# 4. Login app02 servers with root access

# 5. Connect to master and verify any changes in the puppet master confiration file
# puppet agent -tv --noop

# 6. If changes present, then sync the changes with master
# puppet agent -tv 


