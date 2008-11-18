class git {

  package { "zlib-devel": ensure => installed }
  package { "openssl-devel": ensure => installed }
  package { "curl-devel": ensure => installed }
  package { "expat-devel": ensure => installed }
  package { "gettext-devel": ensure => installed }
  package { "wget": ensure => installed }

  $version = '1.6.0.4'

  file { "/usr/local/src": ensure => directory }

  exec { "wget http://kernel.org/pub/software/scm/git/git-$version.tar.gz":
      cwd       => "/usr/local/src",
      source => "puppet://puppet/dist/packages/git-$version.tar.gz",
      alias  => "download-git-tgz",
      before => Exec["untar-git-source"]
  }

  exec { "tar xzf git-$version.tar.gz":
      cwd       => "/usr/local/src",
      creates   => "/usr/local/src/git-$version",
      alias     => "untar-git-source",
      subscribe => File["download-git-tgz"],
      before    => Exec["make install"]
  }

  exec { "make prefix=/usr all && make prefix=/usr install":
      cwd     => "/usr/local/src/git-$version",
      alias   => "make install",
      creates => [ "/usr/bin/git" ],
      require => [Exec["untar-git-source"]]
  }

}