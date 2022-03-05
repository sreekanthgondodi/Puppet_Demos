# ************************************************* Scenario: Puppet Setup NTP Server **************************************************************

# While troubleshooting one of the issue on app servers in Stratos Datacenter DevOps team identified the root cause that the time isn't synchronized properly among all app servers which cause issues sometimes. So team has decided to use a specific time server for all app servers so that they all remain in sync. This task needs to be done using Puppet so as per details mentioned below please compete the task:

# Create a puppet programming file apps.pp under /etc/puppetlabs/code/environments/production/manifests directory on puppet master node i.e on Jump Server. Within the programming file define a custom class ntpconfig to install and configure ntp server on all app servers.

# Also add NTP Server server 1.sg.pool.ntp.org in default configuration file on all app servers.

# Please note that do not try to start/restart/stop ntp service as we already have a scheduled restart for this service tonight and we don't want these changes to be applied right now.

# Note: Please perform this task using apps.pp only, do not try to create any separate inventory file.

# -------------------------------------------------------------------------------------------------------------------------------------------Solution:

# vi /etc/puppetlabs/code/environments/production/manifests/apps.pp

class ntpconfig {

	package { 'ntp':
    ensure  => 'present',
  	}
	
	file { "/etc/ntp.conf":
	  ensure => 'present',
	  content => [ "server 1.sg.pool.ntp.org" ]
	}  
}

node 'stapp01.stratos.xfusioncorp.com', 'stapp02.stratos.xfusioncorp.com', 'stapp03.stratos.xfusioncorp.com' {
include ntpconfig
}

node 'default' {
}
