<VirtualHost *>
    ServerAdmin squirrel@blindpages.com
    DocumentRoot /data/www/blindpages.com
    ServerName www.blindpages.com
    ErrorLog /data/www/log/blindpages.com-error_log
    CustomLog /data/www/log/blindpages.com-access_log common
    ServerAlias blindpages.com www.blindpages.com
</VirtualHost>

