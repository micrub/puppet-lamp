### Introduction
This project allows CCLE developers to automatically create a virtual machine that is running the same LAMP stack that is being used for our Moodle 2 servers to help develop code in a production like environment.

### Prerequisites
* Please make sure you have “Virtualization Technology” or the equivalent setting enabled on your computer’s BIOS.
* Install VirtualBox 4.3.4 and the Extension Pack: https://www.virtualbox.org/wiki/Download_Old_Builds_4_3
* Install Vagrant 1.3.5: http://downloads.vagrantup.com
* Install Git:  http://git-scm.com/
* If running Linux, install NFS:
    * (Ubuntu) sudo apt-get install nfs-common nfs-kernel-server
    * (Other) sudo yum install nfs-common nfs-kernel-server
* Access to the CCLE codebase. Note, you can use this Vagrant VM for vanilla Moodle, just ignore or skip the steps related to the CCLE codebase.
    * Make sure you are using SSH keys to access to the CCLE codebase: https://help.github.com/articles/generating-ssh-keys
* (Windows only) Install Putty and PuttyGen: http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html

### Download and setup VM
1. Check out vagrant and puppet scripts that will create the Dev VM
    * mkdir ~/Projects && cd ~/Projects
    * git clone git://github.com/rlorenzo/puppet-lamp.git ccle
2. Checkout CCLE the codebase from Github
    * cd ~/Projects/ccle
    * git clone git@github.com:ucla/moodle.git
    * cd moodle
    * git submodule init && git submodule update
3. Start vagrant and run the puppet scripts
   * vagrant up

### Pre-moodle install
1. First ssh into the Vagrant VM: 
   * vagrant ssh
2. Create moodle database
   * mysql --user=root --execute="CREATE DATABASE moodle DEFAULT CHARACTER SET UTF8 COLLATE utf8_unicode_ci;"
3. Create moodle user and allow them to access moodle database
   * mysql --user=root --execute="GRANT ALL PRIVILEGES ON moodle.* TO 'moodle'@'localhost' IDENTIFIED BY 'test'; FLUSH PRIVILEGES;"
      * Can replace 'test' with any other password you want to use.

### Setup CCLE version of Moodle
1. On the host computer, create a link to the dev configuration file
      * cd ~/Projects/ccle/moodle
      * ln -s local/ucla/config/shared_dev_moodle-config.php config.php
2. Then copy the file config_private-dist.php to config_private.php and change the dbuser/dbpass/wwroot/dataroot variables to the appropiate values if you are not using the default options.
3. Import a sample database dump that includes prebuild courses, config settings, roles, and a set of test users.
   * Run the following commands to import the database dump:
      * vagrant ssh
      * cd /tmp && wget https://test.ccle.ucla.edu/vagrant/new_moodle_instance.sql
      * mysql -u root -D moodle < /tmp/new_moodle_instance.sql
   * This database dump includes the following user accounts (login/pass):
      * admin/test
      * instructor/test
      * student/test
   * The database dump includes the following items:
      * roles copied from our production server
      * turned off most of the password requirements so that simple passwords can be used for test accounts
      * pre-built courses
4. Install PHPUnit by following the directions at http://docs.moodle.org/dev/PHPUnit#Installation_of_PHPUnit_via_Composer
   * Note: To run phpunit tests, you will need to be in your Vagrant VM and in your moodle directory.
5. Behat
   * Note: Unfortunately we cannot use the VM for Behat development. A separate instance will need to be created. Please refer to https://github.com/alroman/moodle-automated-testing/wiki for additional instructions.    
5. On your host machine, go to http://localhost:8080/moodle and start using the CCLE Moodle codebase.
   * Make sure you upgraded the sample database to the newest version of the CCLE Moodle codebase. Login as admin/test and go to "Site administration >Notifications" and run through the upgrade process.

### NOTES
1. To shutdown the vagrant please run "vagrant suspend" (it is quicker than doing vagrant halt). To start up vagrant again run "vagrant up". To restart the VM, run "vagrant reload".
2. phpMyAdmin is viewable at: http://localhost:8080/phpmyadmin
3. Your code on the Vagrant VM is located at /vagrant/moodle
4. You can gain root access by doing: sudo su -
5. If you upgrade VirtualBox or your Vagrant VM might not be able to mount your directory, because you need to update your VirtualBox guest additions.
   * SSH into your Vagrant VM: vagrant ssh
   * Go to http://download.virtualbox.org/virtualbox/ and download the latest copy of VBoxGuestAdditions\_X.iso for your version of VirtualBox onto /tmp
   * As root (sudo su -):
      * mount -o loop -t iso9660 /tmp/VBoxGuestAdditions\_X.iso /mnt
      * sh /mnt/VBoxLinuxAdditions.run

### Caveats for Windows users
* Git Bash does not support symbolic links. After you do the step of “create a link to the dev configuration file” please realize that you are essentially copying the file. Any updates made to the development configuration file will need to be manually updated by you. Also, since the file is now a copy change the following line:

   ```php
    $_dirroot_ = dirname(realpath(__FILE__)) . '/../../..'; into
    $_dirroot_ = dirname(realpath(__FILE__));
   ```
* You will not be able to “vagrant ssh” into your Vagrant VM. You will need to use putty to ssh. But before you can do that you will need to convert the the vagrant ssh key into a putty ppk file. Please follow this link for more information:
   * Location of vagrant ssh key: http://docs-v1.vagrantup.com/v1/docs/getting-started/ssh.html
   * how to convert insecure_private_key to ppk: http://wazem.blogspot.com/2007/11/how-to-convert-idrsa-keys-to-putty-ppk.html
