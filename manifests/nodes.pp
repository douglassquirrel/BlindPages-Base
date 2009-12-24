node default {
    include apache
    apache::site {"blindpages.com":}

    $mysql_root_password = ""
    include mysql
    mysql::database{"buildbase_production": dbname => 'buildbase_production', ensure => present}
}
