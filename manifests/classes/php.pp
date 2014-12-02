class php {
  package { php: ensure => 'latest' }

  $phppackages = [ "php-mcrypt", "php-mysql", "php-mssql", "php-odbc", "gd", "gd-devel",
  				   "php-gd", "php-mbstring", "php-xml", "php-soap", "php-intl", "php-xmlrpc" ]
  package { $phppackages: ensure => "installed",
  	 					require => [ Package[php] ] }
  package { php-pecl-zendopcache: ensure => "7.0.3-1.el6.remi",
  	 						      require => [ Package[php] ]}

  # Needed for profiling.
  package { xhprof: ensure => "installed" }

  # Custom configs for php.ini and opcache.ini
  file { "/etc/php.ini":
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "/vagrant/files/etc/php.ini",
      require => [ Package[php] ],
  }

  file { "/etc/php.d/opcache.ini":
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "/vagrant/files/etc/php.d/opcache.ini",
      require => [ Package[php-pecl-zendopcache] ],
  }

  # Create log file for Zend Opcache.
  file { "/var/log/opcache_error.log":
      replace => "no", # Make sure file exists, don't replace it.
      ensure  => "present",
      content => "",
      mode    => 664,
  }

  # install xdebug
  package { php-pecl-xdebug: ensure => installed }
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "/vagrant/files/etc/php.d/xdebug.ini",
      require => Package['php-pecl-xdebug'],
  }
}
