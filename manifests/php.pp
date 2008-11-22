class php {

  package {
    php:
    ensure => latest,
    requires => Package[httpd]
  }

  package {
    php-mysql:
    ensure => latest,
    requires => Package[mysql]
  }

}