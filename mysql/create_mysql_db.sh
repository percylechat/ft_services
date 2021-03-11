#!bin/sh

until mysql
do
  echo ""
done

echo "SET old_passwords=0;" | mysql --port=3306 --user=root
echo "CREATE DATABASE wordpress;" | mysql mysql --port=3306 --user=root
echo "USE wordpress;" | mysql --port=3306 --user=root
echo "CREATE USER 'root'@'%' IDENTIFIED BY '';" | mysql --port=3306 --user=root
echo "GRANT ALL ON wordpress.* TO 'root'@'%';" | mysql --port=3306 --user=root
echo "FLUSH PRIVILEGES;" | mysql --port=3306 --user=root
echo "exit" | mysql --port=3306 --user=root