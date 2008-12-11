class php {

  package { php: ensure => installed }
  package { php-mysql: ensure => installed }

  file { "/etc/php.ini":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/etc/puppet/files/etc/php.ini",
      require => [ Package[php] ]
  }

}