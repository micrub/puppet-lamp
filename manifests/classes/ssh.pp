class ssh {

  package { openssh-server: ensure => installed }

  service {
    sshd:
    enable    => true,
    ensure    => running,
    subscribe => [Package[openssh-server], File["/etc/ssh/sshd_config"]]
  }

  file { "/etc/ssh/sshd_config":
      owner   => root,
      group   => root,
      mode    => 660,
      source  => "/etc/puppet/files/etc/ssh/sshd_config",
      require => [ Package[openssh-server] ]
  }

}