class apache {

  package {
    httpd:
    ensure => latest,
    requires => Package[mod_ssl]
  }

  package {
    httpd-devel:
    ensure => latest,
    requires => Package[http]
  }

  package {
    mod_ssl:
    ensure => latest,
    requires => Package[http]
  }

  service {
    httpd:
    enable    => true,
    ensure    => running,
    subscribe => Package[httpd]
  }

}