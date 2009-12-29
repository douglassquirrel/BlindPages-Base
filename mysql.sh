function dosql {
  echo "Executing $1"
  echo "$1" | mysql -uroot -pchangeme314159
}

dosql "GRANT USAGE ON *.* TO 'blindpages'@'localhost'"
dosql "DROP USER 'blindpages'@'localhost'"
dosql "CREATE USER 'blindpages'@'localhost' IDENTIFIED BY '$2'"
dosql "GRANT ALTER, CREATE, DELETE, DROP, INDEX, INSERT, SELECT, UPDATE ON blindpages.* TO 'blindpages'@'localhost'"

mysqladmin -uroot -pchangeme314159 password $1
