cat init.sql | while read sql
do
  echo "Executing $sql"
  echo "$sql" | mysql -uroot -pchangeme314159
done

mysqladmin -uroot -pchangeme314159 password $1
