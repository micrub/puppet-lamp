# Install and setup clamav
class clamav {
  package { "clamd": ensure => installed }
	
  service { 'clamd':
      enable    => true,
      ensure    => running,
      require   => Package['clamd']
  }	
  
  # make sure newest virus definitions are installed
  exec { "freshclam":
      command => "freshclam",
      path    => "/usr/bin/",   
      require => Service["clamd"]   
  }    
}
