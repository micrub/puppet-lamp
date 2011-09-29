class mysql {
  package { 	
		mysql-server: 			ensure => installed ,
  		libapache2-mod-auth-mysql: 	ensure => installed,
		php5-mysql:			ensure=>installed,
		phpmyadmin:			ensure=>installed,
  }

  #service {
  #  mysqld:
  #  enable    => true,
  #  ensure    => running,
  #  subscribe => Package[mysql-server]
  #}

}
