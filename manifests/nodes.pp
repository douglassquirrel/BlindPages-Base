node default {
#    include apache
#    apache::site {"blindpages.com":}

    include mysql
#    $mysql_root_password = ""
    mysql::database{"blindpages": dbname => 'blindpages', ensure => present}
}
