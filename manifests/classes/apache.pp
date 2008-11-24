class apache {

  package { httpd: ensure => installed }
  package { httpd-devel: ensure => installed }
  package { mod_ssl: ensure => installed }


  service {
    httpd:
    enable    => true,
    ensure    => running,
    subscribe => Package[httpd]
  }

}