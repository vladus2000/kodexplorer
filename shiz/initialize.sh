cp -a /usr/src/kodexplorer/* /var/www/html
if [ -e /var/www/html/data ]; then
	cp -a /usr/src/kodexplorer_data/* /var/www/html/data
fi
chown -R user /var/www/html
chmod -R 777 /var/www/html

