file { "/etc/sudoers":
    owner => root, group => root, mode => 440
}
node default {
  include build,
          git,
          apache,
          mysql,
          php
}