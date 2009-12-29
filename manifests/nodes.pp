node default {
    include apache2::install
    apache::site {"blindpages.com":}

    include mysql
    $mysql_root_password = "changeme314159"
    mysql::database{"blindpages": dbname => 'blindpages', ensure => present}
}
