node default {
    include apache2::install
    apache::site {"blindpages.com":}

    $mysql_root_password = "changeme314159"
    include mysql
    mysql::database{"blindpages": dbname => 'blindpages', ensure => present}

    include apache::passenger
}
