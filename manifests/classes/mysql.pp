class mysql {

  package { mysql: ensure => installed }
  package { mysql-server: ensure => installed }

  service {
    mysqld:
    enable    => true,
    ensure    => running,
    subscribe => Package[mysql-server]
  }

  case $mysql_root_password {
    '': { fail("You need to define a mysql root password! Please set \$mysql_root_password in your site.pp") }
  }

  case $wordpress_db_user {
    '': { fail("You need to define a mysql user for wordpress! Please set \$wordpress_db_user in your site.pp") }
  }

  case $wordpress_db_password {
    '': { fail("You need to define a mysql password for wordpress! Please set \$wordpress_db_password in your site.pp") }
  }

  case $wordpress_db_name {
    '': { fail("You need to define a mysql database for wordpress! Please set \$wordpress_db_name in your site.pp") }
  }

  exec { "mysql-root-password":
    environment => "PASSWORD=$mysql_root_password",
    unless      => "mysqladmin -uroot -p\${PASSWORD} status",
    path        => "/bin:/usr/bin",
    command     => "mysqladmin -uroot password \${PASSWORD}",
    before      => [Exec["mysql-wordpress-db"]]
   }

  exec { "mysql-wordpress-db":
    environment => "PASSWORD=$mysql_root_password",
    unless      => "echo 'select 1' | mysql -uroot -p\${PASSWORD} $wordpress_db_name",
    path        => "/bin:/usr/bin",
    command     => "mysqladmin -uroot -p\${PASSWORD} create $wordpress_db_name",
    before      => [Exec["mysql-wordpress-user"]]
  }

  exec { "mysql-wordpress-user":
    environment => ["ROOT_PASSWORD=$mysql_root_password","WORDPRESS_PASSWORD=$wordpress_db_password"],
    unless      => "echo 'select 1' | mysql -u$wordpress_db_user -p\${WORDPRESS_PASSWORD} $wordpress_db_name",
    path        => "/bin:/usr/bin",
    command     => "echo 'GRANT ALL PRIVILEGES ON $wordpress_db_name.* to \"$wordpress_db_user\"@\"localhost\" IDENTIFIED BY \"$wordpress_db_password\"; FLUSH PRIVILEGES;' | mysql -uroot -p\${ROOT_PASSWORD}"
   }

}