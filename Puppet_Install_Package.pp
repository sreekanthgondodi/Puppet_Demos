# ****************************************************** Scenario: Puppet Install a Package *****************************************************

# New packages need to be installed on all app servers in Stratos Datacenter. The Nautilus DevOps team has decided to install the same using Puppet. Since jump host is already configured to run as Puppet master server and all app servers are already configured to work as puppet agent nodes, we need to create required manifests on the Puppet master server so that the same can be applied on all Puppet agent nodes. Please find more details about the task below.

# Create a Puppet programming file ecommerce.pp under /etc/puppetlabs/code/environments/production/manifests directory on master node i.e Jump Server and using puppet package resource perform the tasks below.

# Install package nginx through Puppet package resource on all Puppet agent nodes i.e all App Servers.
# Note: Please perform this task using ecommerce.pp only, do not create any separate inventory file.

# ----------------------------------------------------------------------------------------------------------------------------------------
# Solution:

# 1. Create puppet file 

vi /etc/puppetlabs/code/environments/production/manifests/ecommerce.pp

class nginx_install {

	package { 'nginx':
    ensure  => 'installed',
  	}


node 'stapp01.stratos.xfusioncorp.com', 'stapp02.stratos.xfusioncorp.com', 'stapp03.stratos.xfusioncorp.com' {
include nginx_install
}

node 'default' {
}


# 2. Complile and test beta.pp file   
# puppet parser validate ecommerce.pp
# puppet apply ecommerce.pp --noop

# 3. Apply/Execute the apps.pp file
# puppet apply ecommerce.pp

# 4. Login app01/02/03 servers with root access

# 5. Connect to master and verify any changes in the puppet master confiration file
# puppet agent -tv --noop

# 6. If changes present, then sync the changes with master
# puppet agent -tv 

