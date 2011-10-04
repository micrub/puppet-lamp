class lamp {

      	exec { "apt-update":
      	  command     => "/usr/bin/apt-get update",
      	  refreshonly => true;
      	}

  	include apache-params
  	include apache
	include php
	include mysql
	#TODO : configure fqdn
}
