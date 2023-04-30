# Ansible Playbook to Install Nginx Offline and Allow Port 80 in Firewall

This Ansible playbook is designed to install Nginx on a target server offline (i.e., without an internet connection). It also allows port 80 in the firewall of the server.

# Requirements

  1. Ansible installed on the control machine

  2. A target server (in this case, client2) running CentOS 7 or later

# Instructions

   1. Copy the nginx-1.23.4.tar.gz and nginx.service files to the control machine.

   2. Modify the nginx.service file to match the configuration of your Nginx installation.

   3. Create a new playbook file and copy the contents of the **nginx-offline.yml** file into it.

   4. Replace the hosts parameter with the IP address or hostname of your target server.
    
   5. Save the playbook file.

   6. Open a terminal and navigate to the directory containing the playbook file.

   7. Run the following command to execute the playbook:

     ansible-playbook playbook.yml

# The playbook will perform the following tasks

    1. Create an empty nginx.sh file
    2. Copy the nginx-1.23.4.tar.gz file to the target server
    3. Extract the nginx-1.23.4.tar.gz file
    4. Install the necessary dependencies for Nginx
    5. Configure Nginx
    6. Add Nginx to the system path
    7. Create an Nginx service file
    8. Reboot the target server
    9. Wait for the target server to come back online
    10. Allow port 80 in the firewall of the target server
