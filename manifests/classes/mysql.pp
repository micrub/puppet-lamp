class mysql {

  package { mysql: ensure => latest }
  package { mysql-server: ensure => latest }

  service {
    mysqld:
    enable    => true,
    ensure    => running,
    subscribe => Package[mysql-server]
  }

}