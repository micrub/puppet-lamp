class mysql {

  	user { "mysql":
  	  ensure => present,
  	  require => Package["mysql-server"],
  	}
	package { "mysql-server" :		ensure => installed }
	package { "libapache2-mod-auth-mysql": 	ensure => installed }
	package { "php5-mysql":			ensure=>installed }
	package { "phpmyadmin":			ensure=>installed }

 	service { "mysql":
 	   ensure      => running,
 	   enable      => true,
 	   name        => $operatingsystem ? {
 	     /RedHat|Fedora|CentOS/ => "mysqld",
 	     default => "mysql",
 	   },
 	   require   => Package["mysql-server"],
 	 }
}
