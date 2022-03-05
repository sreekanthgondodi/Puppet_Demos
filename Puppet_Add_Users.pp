// ******************************************** Scenario: Puppet Add Users **************************************************************

// A new teammate has joined the Nautilus application development team, the application development team has asked the DevOps team to create a new user account for the new teammate on application server 3 in Stratos Datacenter. The task needs to be performed using Puppet only. You can find more details below about the task.

// Create a Puppet programming file blog.pp under /etc/puppetlabs/code/environments/production/manifests directory on master node i.e Jump Server, and using Puppet user resource add a user on all app servers as mentioned below:

// Create a user james and set its UID to 1735 on Puppet agent nodes 3 i.e App Servers 3.
// Notes: :- Please make sure to run the puppet agent test using sudo on agent nodes, otherwise you can face certificate issues. In that case you will have to clean the certificates first and then you will be able to run the puppet agent test.

// :- Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

// :- Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.

// ------------------------------------------------------------------------------------------------------------------------------------------
//Solution:

//1: create puppet file /etc/puppetlabs/code/environments/production/manifests/blog.pp

class create_user {
   user { 'james':
     ensure => present,
	  uid => 1735
	}
}

node 'stapp03.stratos.xfusioncorp.com' {
  include create_user
}

node 'default' {
}

// 2: Complile and test beta.pp file   
// puppet parser validate blog.pp 
// puppet apply blog.pp  --noop

// 3: Apply/Execute the demo.pp  file
// puppet apply demo.pp 

// 4: Login app01/02/03 servers with root access

// 5: Connect to master and verify any changes in the puppet master confiration file
//puppet agent -tv --noop

// 6: If changes present, then sync the changes with master
// puppet agent -tv 

