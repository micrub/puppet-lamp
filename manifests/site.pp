import 'classes/*'
node default {
  $mysql_root_password = ''
  $wordpress_db_user = ''
  $wordpress_db_password = ''
  $wordpress_db_name = ''
  include wordpress
}