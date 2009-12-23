define mysql::database($dbname, $ensure) {

    case $ensure {
        present: {
            exec { "Mysql: create $dbname db":
                    command => "/usr/bin/mysql -u root --execute=\"CREATE DATABASE $dbname\";",
                    unless => "/usr/bin/mysql -u root --execute=\"SHOW DATABASES;\" | grep '$dbname'",
                    require => Class['mysql']
            }
        }
        absent: {
            exec { "Mysql: drop $dbname db":
                    command => "/usr/bin/mysql -u root --execute=\"DROP DATABASE $dbname\";",
                    onlyif => "/usr/bin/mysql -u root --execute=\"SHOW DATABASES;\" | grep '$dbname'",
                    require => Class['mysql']
            }
        }
        default: {
            fail "Invalid 'ensure' value '$ensure' for mysql::database"
        }
    }
}

# define mysql::user($password) {
#   exec { "Mysql: create $name user":
#                   command = "/usr/bin/echo 'CREATE USER \'${name}\'@\'localhost\' IDENTIFIED BY \'${password}\'; 
#                   GRANT ALL PRIVILEGES ON *.* TO \'monty\'@\'localhost\' WITH GRANT OPTION;"}
#                   onlyif => 
# }
