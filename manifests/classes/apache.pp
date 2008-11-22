class apache {

  package { httpd: ensure => latest }
  package { httpd-devel: ensure => latest }
  package { mod_ssl: ensure => latest }


  service {
    httpd:
    enable    => true,
    ensure    => running,
    subscribe => Package[httpd]
  }

}