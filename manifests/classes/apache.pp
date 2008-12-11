class apache {

  package { httpd: ensure => installed }
  package { httpd-devel: ensure => installed }
  package { mod_ssl: ensure => installed }


  service {
    httpd:
    enable    => true,
    ensure    => running,
    subscribe => [Package[httpd], File["/etc/httpd/conf/httpd.conf"], Package[php], File["/etc/php.ini"]]
  }

  file { "/etc/httpd/conf/httpd.conf":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/etc/puppet/files/etc/httpd/conf/httpd.conf",
      require => [ Package[httpd] ]
  }

}