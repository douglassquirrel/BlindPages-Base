for sql in "GRANT USAGE ON *.* TO 'blindpages'@'localhost'; DROP USER 'blindpages'@'localhost'"                           \
           "CREATE USER 'blindpages'@'localhost' IDENTIFIED BY '$2'"                                                      \
           "GRANT ALTER, CREATE, DELETE, DROP, INDEX, INSERT, SELECT, UPDATE ON blindpages.* TO 'blindpages'@'localhost'" 
do
  echo $sql | mysql -uroot -pchangeme314159
done

mysqladmin -uroot -pchangeme314159 password $1
