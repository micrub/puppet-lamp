class apache {

  package { 'apache2' : ensure => installed }

  service {
    'apache2' :
    enable    => true,
    ensure    => running,
    subscribe => [Package['apache2']]
  }

  #file { "/etc/httpd/conf/httpd.conf":
  #    owner   => root,
  #    group   => root,
  #    mode    => 660,
  #    source  => "/etc/puppet/files/etc/httpd/conf/httpd.conf",
  #    require => [ Package[httpd] ]
  #}

}
