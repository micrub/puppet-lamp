class mysql {
  $mysqlpackages = [ "mysql", "mysql-libs", "mysql-server" ]
  package { $mysqlpackages: ensure => "latest" }

  service {
    mysqld:
    enable    => true,
    ensure    => running,
    subscribe => Package["mysql-server"]
  }

  file { "/etc/my.cnf":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/vagrant/files/etc/my.cnf",
      require => [ Package["mysql-server"] ],
      notify  => Service["mysqld"],
  }
}
