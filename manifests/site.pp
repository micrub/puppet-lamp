import 'classes/*'
node default {
  # $wordpress_user_password = ''
  $mysql_root_password = ''
  $wordpress_db_user = ''
  $wordpress_db_password = ''
  $wordpress_db_name = ''
  include wordpress
}