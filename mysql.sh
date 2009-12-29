echo "GRANT USAGE ON *.* TO 'blindpages'@'localhost'; DROP USER 'blindpages'@'localhost'" | mysql -uroot -pchangeme314159
echo "CREATE USER 'blindpages'@'localhost' IDENTIFIED BY '$2'" | mysql -uroot
echo "GRANT ALTER, CREATE, DELETE, DROP, INDEX, INSERT, SELECT, UPDATE ON blindpages.* TO 'blindpages'@'localhost'" | mysql -uroot -pchangeme314159
mysqladmin -uroot -pchangeme314159 password $1
