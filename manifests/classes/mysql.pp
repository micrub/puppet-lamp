class mysql {

  package { mysql: ensure => installed }
  package { mysql-server: ensure => installed }

  service {
    mysqld:
    enable    => true,
    ensure    => running,
    subscribe => Package[mysql-server]
  }

}