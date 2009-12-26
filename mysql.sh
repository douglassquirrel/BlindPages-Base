echo "CREATE USER 'blindpages'@'localhost' IDENTIFIED BY '$2'" | mysql -uroot
echo "GRANT ALTER, CREATE, DELETE, DROP, INDEX, INSERT, SELECT, UPDATE ON blindpages.* TO 'blindpages'@'localhost'" | mysql -uroot
mysqladmin -uroot password $1
