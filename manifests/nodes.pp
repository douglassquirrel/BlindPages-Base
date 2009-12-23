node default {

    $mysql_root_password = "MY_BIG_SECRET"
include mysql
    mysql::database{"buildbase_production": dbname =>
'buildbase_production', ensure => present}

}
