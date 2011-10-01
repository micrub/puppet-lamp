class php {

  package { 
		"php5" : ensure => installed,
		"libapache2-mod-php5" : ensure => installed,
  }

}
