class mysql {

  package{ [mysql-client, mysql-server, libmysqlclient15-dev]: ensure => installed }
  
  if $mysql_root_password { 
        
        exec { "Set MySQL server root password":
          unless => "mysqladmin -uroot -p$mysql_root_password status",
          path => "/bin:/usr/bin",
          command => "mysqladmin -uroot password $mysql_root_password",
          require => [ Package["mysql-server"], Package["mysql-client"] ]
        }
    }
    else {
        warning("no mysql root password given - sorry")
    }
  }

