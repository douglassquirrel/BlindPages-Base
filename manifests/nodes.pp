node default {

    $mysql_root_password = ""
include mysql
    mysql::database{"buildbase_production": dbname =>
'buildbase_production', ensure => present}

}
