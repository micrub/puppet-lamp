class php {
  package { 
		"php5" : 
			ensure => installed,
  }
  package { 
		"libapache2-mod-php5" : 
			ensure => installed,
			require => Package["php5"]
  }

}
