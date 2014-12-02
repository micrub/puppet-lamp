class phpmyadmin {
  #package { "phpmyadmin": ensure => installed, disablerepo => "rpmforge" }  
  # want to use new version of phpmyadmin, but puppet doesn't
  # yet support "disablerepo" syntax, so do it via command line
  # http://projects.puppetlabs.com/issues/2247  
#  package { 'phpMyAdmin':
#  	require => Exec["install_phpmyadmin"]
#  }
	
#  exec { "install_phpmyadmin":
#      command => "yum --disablerepo=rpmforge -y install phpMyAdmin",
#      path    => "/usr/bin/",
#      unless  => "yum list installed | grep phpMyAdmin | wc -l"
#  }  
	
  package { phpMyAdmin: ensure => "latest" }
	
  # make sure that config file is set
  file { "/etc/phpMyAdmin/config.inc.php":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "/vagrant/files/phpmyadmin/config.inc.php",
    require => Package["phpMyAdmin"]
  }	  	
  	
  # make sure that apache conf file is set
  file { "/etc/httpd/conf.d/phpMyAdmin.conf":
   	owner   => root,
   	group   => root,
   	mode    => 644,
   	source  => "/vagrant/files/phpmyadmin/phpmyadmin.conf",
   	require => Package["phpMyAdmin"],
   	notify	=> Service["httpd"],
  }  	
}
