# *************************************************** Scenario: Puppet String Manipulation ********************************************************

# There is some data on App Server 3 in Stratos DC. The Nautilus development team shared some requirement with the DevOps team to alter some of the data as per recent changes. The DevOps team is working to prepare a Puppet programming file to accomplish this. Below you can find more details about the task.

# Create a Puppet programming file official.pp under /etc/puppetlabs/code/environments/production/manifests directory on Puppet master node i.e Jump Server and by using puppet file_line resource perform the following tasks.

# We have a file /opt/dba/official.txt on App Server 3. Use the Puppet programming file mentioned above to replace line Welcome to Nautilus Industries! to Welcome to xFusionCorp Industries!, no other data should be altered in this file.
# Note: Please perform this task using official.pp only, do not create any separate inventory file.

# ---------------------------------------------------------------------------------------------------------------------------
# Solution:

class data_replacer {
  file_line { 'line_replace':
    path => '/opt/dba/official.txt',
    match => 'Welcome to Nautilus Industries!',
    line  => 'Welcome to xFusionCorp Industries!',
  }
}

node 'stapp03.stratos.xfusioncorp.com' {
  include data_replacer
}

node 'default' {
}


# 2. Complile and test official.pp file   
# puppet parser validate official.pp 
# puppet apply official.pp --noop

# 3. Apply/Execute the official.pp  file
# puppet apply official.pp

# 4. Login app03 servers with root access

# 5. Connect to master and verify any changes in the puppet master confiration file
# puppet agent -tv --noop

# 6. If changes present, then sync the changes with master
# puppet agent -tv 

