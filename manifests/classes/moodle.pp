class moodle {
	# create directory to store moodle files
	file { 
   		'/opt/moodledata':
    	ensure => directory,
    	mode   => 0777,
	}

	# create directory to store moodle phpunit files
	file { 
   		'/opt/phpu_moodledata':
    	ensure => directory,
    	mode   => 0777,
	}
	
	# create directory to store moodle behat files
	file { 
   		'/opt/bht_moodledata':
    	ensure => directory,
    	mode   => 0777,
	}	
	
	# Java & Firefox are needed for Selenium. Xvfb is for headless Firefox, see:
	# http://www.alittlemadness.com/2008/03/05/running-selenium-headless/
	package { "java-1.7.0-openjdk-devel": ensure => installed }
	package { "firefox": ensure => installed } 
	package { "xorg-x11-server-Xvfb": ensure => installed } 
	
	# Create link to moodle source my copying moodle.conf to appropiate place.
    file { "/etc/httpd/conf.d/moodle.conf":
        owner   => root,
        group   => root,
        mode    => 660,
        source  => "/vagrant/files/etc/httpd/conf.d/moodle.conf",
        require => [ Package[httpd] ]
    }
    
	# We used to link directly to the moodle directory, now we don't.
	file { "/var/www/html/moodle":
 		ensure => absent
 	}    
	
	# make sure aspell is installed
	package { "aspell.x86_64": ensure => installed }  
	
	# install ghostscript (it is needed for PDF submission assignment type)
	package { "ghostscript.x86_64": ensure => installed }  
	
	# course creator fails if sendmail is not installed	
	# NOTE: This means that the VM can potentially send email out
	# Please use caution when using scripts that send out email
	package { sendmail: ensure => installed }  

#	# setup moodle cron
#	cron {
#		moodle_cron:
#			command => "/usr/bin/php /vagrant/moodle/admin/cli/cron.php",
#			user => vagrant,
#			minute => '*/30',
#			require => Service["vixie-cron"]
#	}	
}
