class apache {

  package { 'apache2' : ensure => installed }

  service {
    'apache2' :
    enable    => true,
    ensure    => running,
    subscribe => [Package['apache2']]
  }

 file {"default virtualhost":
    path    => "${apacheparams::conf}/sites-available/default",
    ensure  => present,
    content => template("../../templates/vhost.erb"),
    require => Package["apache2"],
    notify  => Exec["apache-graceful"],
    mode    => 644,
  }
  exec { "apache-graceful":
    command => undef,
    refreshonly => true,
    onlyif => undef,
  }
}
