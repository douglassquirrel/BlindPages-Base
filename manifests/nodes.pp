node default {
#    apache::site {"blindpages.com":}

    $mysql_root_password = ""
    mysql::database{"buildbase_production": dbname => 'buildbase_production', ensure => present}
}
