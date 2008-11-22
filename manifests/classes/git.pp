class git {

  package { zlib-devel: ensure => latest }
  package { openssl-devel: ensure => latest }
  package { curl-devel: ensure => latest }
  package { expat-devel: ensure => latest }
  package { gettext-devel: ensure => latest }
  package { wget: ensure => latest }

  $version = '1.6.0.4'

  file { "/usr/local/src": ensure => directory }

  exec { "download-git-tgz":
      cwd       => "/usr/local/src",
      command   => "/usr/binwget http://kernel.org/pub/software/scm/git/git-$version.tar.gz",
      before    => Exec["untar-git-source"],
      require   => [Package[wget]]
  }

  exec { "untar-git-source":
      command   => "/bin/tar xzf git-$version.tar.gz",
      cwd       => "/usr/local/src",
      creates   => "/usr/local/src/git-$version",
      subscribe => File["download-git-tgz"],
      before    => Exec["make-install-git"]
  }

  exec { "make-install-git":
      cwd       => "/usr/local/src/git-$version",
      command   => "/usr/bin/make prefix=/usr all && make prefix=/usr install",
      creates   => [ "/usr/bin/git" ],
      require   => [Exec["untar-git-source"],Package[gcc],Package[make],Package[gettext-devel],Package[expat-devel],Package[curl-devel],Package[openssl-devel],Package[zlib-devel]]
  }

}