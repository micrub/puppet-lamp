class apache {
  package { httpd: ensure => "latest" }
  package { httpd-devel: ensure => installed }
  package { mod_ssl: ensure => installed }

  service {
    'apache2' :
    enable    => true,
    ensure    => running,
    subscribe => [Package[httpd], 
    			  File["/etc/httpd/conf/httpd.conf"], 
    			  Package[php], 
    			  File["/etc/php.ini"],
    			  File["/etc/httpd/conf.d/moodle.conf"]]
  }

  file { "/etc/httpd/conf/httpd.conf":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/vagrant/files/etc/httpd/conf/httpd.conf",
      require => [ Package[httpd] ]
  }
}
