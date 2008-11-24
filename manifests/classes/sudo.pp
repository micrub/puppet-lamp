class sudo {
  package { sudo: ensure => installed }

  file { "/etc/sudoers":
      owner   => root,
      group   => root,
      mode    => 440,
      source  => "/etc/puppet/files/etc/sudoers",
      require => [ Package[“sudo”] ]
  }
}