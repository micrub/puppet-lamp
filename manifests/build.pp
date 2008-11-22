class build {
  package { gcc: ensure => installed }
  package { make: ensure => installed }
}
