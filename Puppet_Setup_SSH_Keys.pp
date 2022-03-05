// *********************************************** Scenario: Puppet Setup SSH Keys ***************************************************************

// The Puppet master and Puppet agent nodes have been set up by the Nautilus DevOps team to perform some testing. In Stratos DC all app servers have been configured as Puppet agent nodes. They want to setup a password less SSH connection between Puppet master and Puppet agent nodes and this task needs to be done using Puppet itself. Below are details about the task:

// Create a Puppet programming file cluster.pp under /etc/puppetlabs/code/environments/production/manifests directory on the Puppet master node i.e on Jump Server. Define a class ssh_node1 for agent node 1 i.e App Server 1, ssh_node2 for agent node 2 i.e App Server 2, ssh_node3 for agent node3 i.e App Server 3. You will need to generate a new ssh key for thor user on Jump Server, that needs to be added on all App Servers.

// Configure a password less SSH connection from puppet master i.e jump host to all App Servers. However, please make sure the key is added to the authorized_keys file of each app's sudo user (i.e tony for App Server 1).

// Notes: :- Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

// :- Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.

// -------------------------------------------------------------------------------------------------------------------------------------------
// Solution:

// 1. Generate public keys in Jump Host.
// ssh-keygen -t rsa

// 2. Copy the key in the pubfile
// cat /home/thor/.ssh/id_rsa.pub

// 3. create puppet file /etc/puppetlabs/code/environments/production/manifests/cluster.pp to copy keys from jump host to all app servers

class ssh_node1 {
  ssh_authorized_key { 'tony@stapp01.stratos.xfusioncorp.com':
  ensure => present,
  user   => 'tony',
  type   => 'ssh-rsa',
  key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCtQKXmWB3zlmJvK5XYMsWYOqpU3aUnZMDV2bQ+CqYlLVGOCWWbCCCrxlPvB+/VHYxLRBRGHeHAefQ2xK2bsigSWXEs6gTkCrhnRAtzraDPuvHZ+4LiJByJepks+CiokxbeJFdFCGMUR0gduTFHHGm0AaLWfNq/XJhZHyWcpl2+ND5NfZ5FF0u1Ef+X09nhm9IQaxcYS76vQoy7dVbK6Eyk/KPlLZ+n5fRY1szgI41afDAzla5QeJEPN3sTXMFBX+wobykUlGOVX1l0l7j1o7vqJCGpTREkDUdB4FGRn0i2tOg0w0fKOU2fTEFqgVodudm2a30s4Kdix75e7+weiUS9',
}
}

class ssh_node2 {
  ssh_authorized_key { 'steve@stapp02.stratos.xfusioncorp.com':
  ensure => present,
  user   => 'steve',
  type   => 'ssh-rsa',
  key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCtQKXmWB3zlmJvK5XYMsWYOqpU3aUnZMDV2bQ+CqYlLVGOCWWbCCCrxlPvB+/VHYxLRBRGHeHAefQ2xK2bsigSWXEs6gTkCrhnRAtzraDPuvHZ+4LiJByJepks+CiokxbeJFdFCGMUR0gduTFHHGm0AaLWfNq/XJhZHyWcpl2+ND5NfZ5FF0u1Ef+X09nhm9IQaxcYS76vQoy7dVbK6Eyk/KPlLZ+n5fRY1szgI41afDAzla5QeJEPN3sTXMFBX+wobykUlGOVX1l0l7j1o7vqJCGpTREkDUdB4FGRn0i2tOg0w0fKOU2fTEFqgVodudm2a30s4Kdix75e7+weiUS9',
}
}

class ssh_node3 {
  ssh_authorized_key { 'steve@stapp03.stratos.xfusioncorp.com':
  ensure => present,
  user   => 'banner',
  type   => 'ssh-rsa',
  key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCtQKXmWB3zlmJvK5XYMsWYOqpU3aUnZMDV2bQ+CqYlLVGOCWWbCCCrxlPvB+/VHYxLRBRGHeHAefQ2xK2bsigSWXEs6gTkCrhnRAtzraDPuvHZ+4LiJByJepks+CiokxbeJFdFCGMUR0gduTFHHGm0AaLWfNq/XJhZHyWcpl2+ND5NfZ5FF0u1Ef+X09nhm9IQaxcYS76vQoy7dVbK6Eyk/KPlLZ+n5fRY1szgI41afDAzla5QeJEPN3sTXMFBX+wobykUlGOVX1l0l7j1o7vqJCGpTREkDUdB4FGRn0i2tOg0w0fKOU2fTEFqgVodudm2a30s4Kdix75e7+weiUS9',
}
}

node 'stapp01.stratos.xfusioncorp.com',	'stapp02.stratos.xfusioncorp.com', 'stapp03.stratos.xfusioncorp.com' {
  include ssh_node1,ssh_node2,ssh_node3
}

node 'default' {
}

// 4. Complile and test beta.pp file   
// puppet parser validate blog.pp 
// puppet apply blog.pp  --noop

// 5. Apply/Execute the demo.pp  file
// puppet apply demo.pp 

// 6. Login app01/02/03 servers with root access

// 7. Connect to master and verify any changes in the puppet master confiration file
// puppet agent -tv --noop

//8. If changes present, then sync the changes with master
//puppet agent -tv 

// 9. ssh from jump host to all appservers without entering password.
// ssh tony@stapp01
// ssh steve@stapp02
// ssh banner@stapp03

