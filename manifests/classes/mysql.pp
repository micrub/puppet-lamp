class mysql {
	package { "mysql-server" :		ensure => installed }
	package { "libapache2-mod-auth-mysql": 	ensure => installed }
	package { "php5-mysql":			ensure=>installed }
	package { "phpmyadmin":			ensure=>installed }

  #service {
  #  mysqld:
  #  enable    => true,
  #  ensure    => running,
  #  subscribe => Package[mysql-server]
  #}

}
