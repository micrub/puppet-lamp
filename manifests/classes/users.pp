class user::virtual {
  @user { "wordpress":
      ensure  => "present",
      uid     => "500",
      gid     => "500",
      home    => "/home/wordpress",
      shell   => "/bin/bash",
  }
}