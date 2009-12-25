node default {
    include apache2
    apache2::site {"blindpages.com":}

    include mysql
    $mysql_root_password = ""
    mysql::database{"buildbase_production": dbname => 'buildbase_production', ensure => present}
}
