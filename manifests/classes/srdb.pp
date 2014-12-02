class srdb {

  #package { "freetds.x86_64": ensure => installed, disablerepo => "remi" }  
  # need to use old version of freetds to connect, but puppet doesn't
  # yet support "disablerepo" syntax, so do it via command line
  # http://projects.puppetlabs.com/issues/2247
  exec { "install_freetds":
      command => "yum --disablerepo=remi -y install freetds",
      path    => "/usr/bin/",     
      unless  => "yum list installed | grep freetds | wc -l"       
  }  
  
  file { "/etc/freetds.conf":
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "/vagrant/files/etc/freetds.conf",
      require => [ Exec["install_freetds"] ]
  }

  file { "/etc/odbc.ini":
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "/vagrant/files/etc/odbc.ini",
      require => [ Package["php-odbc"] ]
  }

}