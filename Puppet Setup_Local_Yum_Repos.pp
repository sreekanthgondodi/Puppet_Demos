# ************************************************** Scenario: Setup Local Yum Repositories **********************************************

# The Nautilus DevOps team was working on developing some custom RPMs to meet some application needs. Most of those RPMs will be installed on all application servers in Stratos Datacenter. So to accomplish this task we need to configure a local yum repository on all app servers so that we can install those custom RPMs from that local yum repository. But this task needs to be done using Puppet, below you can find more details.

# Create a puppet programming file apps.pp under /etc/puppetlabs/code/environments/production/manifests directory on master node i.e on Jump Server. Define a class local_yum_repo and perform below mentioned tasks:

#There are some RPMs already present at location /packages/downloaded_rpms on all puppet agent nodes i.e on all App Servers.

# Create a local yum repository named localyum (make sure to set Repository ID to localyum). Configure it to use packages location /packages/downloaded_rpms on all puppet agent nodes i.e on all App Servers.

# Install package wget from this newly created repository through on all puppet agent nodes i.e on all App Servers.

# Make sure to create a single puppet programming file apps.pp to configure local yum repository and install the package.

# Note: Please perform this task using apps.pp only, do not create any separate inventory file.

# -------------------------------------------------------------------------------------------------------------------------------------------
# Solution:

# 1. Create file apps.pp at below path

# cd /etc/puppetlabs/code/environments/production/manifests/

# vi apps.pp

class local_yum_repo {
yumrepo { 'localyum':
enabled => 1,
descr => 'Local repo for application packages',
baseurl => 'file:///packages/downloaded_rpms',
gpgcheck => 0,
}

package { 'wget':
    ensure  => 'installed',
    require => Yumrepo['localyum'],        
}
}

node 'stapp01.stratos.xfusioncorp.com', 'stapp02.stratos.xfusioncorp.com', 'stapp03.stratos.xfusioncorp.com' {
include local_yum_repo
}

node 'default' {
}

# 2. Complile and test apps.pp file   
# puppet parser validate apps.pp 
# puppet apply apps.pp --noop

# 3. Apply/Execute the apps.pp file
# puppet apply apps.pp

# 4. Login app01/02/03 servers with root access

# 5. Connect to master and verify any changes in the puppet master confiration file
# puppet agent -tv --noop

# 6. If changes present, then sync the changes with master
# puppet agent -tv 


