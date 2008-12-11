class mysql {

  package { mysql: ensure => installed }
  package { mysql-server: ensure => installed }

  service {
    mysqld:
    enable    => true,
    ensure    => running,
    subscribe => Package[mysql-server]
  }

  file { "/etc/my.cnf":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/etc/puppet/files/etc/my.cnf",
      require => [ Package[mysql-server] ]
  }

}