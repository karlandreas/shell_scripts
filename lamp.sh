## install lamp server
#if sudo tasksel install lamp-server ; then
#	echo "LAMP server installed successfully"
#else
#	echo "Error installing LAMP server .."
#	exit 1
#fi
## enable apache-ssl
#if sudo a2enmod ssl ; then
#	echo "Apache SSL enabled"
#	if sudo a2ensite default-ssl ; then
#		echo "Default ssl site enabled"
#	else
#		echo "error enabling default ssl site"
#		exit 1
#	fi
#else
#	echo "Error enabling Apache SSL"
#	exit 1
#fi
## create apache folders and remove default files
#if sudo rm -fR /etc/apache2/sites-enabled/* ; then
#	echo "removed default sites"
#	if sudo mkdir /var/www/html ; then
#		echo "/var/www/html created successfully"
#		if sudo mv /var/www/index.html /var/www/html ; then
#			echo "index.html moved to /var/www/html"
#		else
#			echo "error moving index.html"
#		fi
#	else
#		echo "error creating /var/www/html"
#		exit 1
#	fi
#else
#	echo "Error removing default sites"
#	exit 1
#fi
#
# write /etc/apache2/httpd.conf
HTTPD="ServerName mserve.kajohansen.com\nDocumentRoot '/var/www/html'\n<Directory '/var/www/html'>\n\tOptions Indexes FollowSymLinks\n\tAllowOverride ALL\n\tOrder allow,deny\n\tAllow from all\n</Directory>\n\nNameVirtualHost *:443\n\n<VirtualHost *:80>\n\tServerAdmin webmaster@kajohansen.com\n\tDocumentRoot /var/www/html\n\tDirectoryIndex index.html index.php\n\tErrorLog /var/log/apache2/error.log\n\tCustomLog /var/log/apache2/access.log common\n\n\t<Directory '/var/www/html'>\n\t\tOptions None\n\t\tAllowOverride ALL\n\t\tOrder allow,deny\n\t\tAllow from all\n\t</Directory>\n</VirtualHost>"
if sudo echo -e $HTTPD | sudo tee -a /etc/apache2/httpd.conf ; then
	echo "httpd.conf write success"
else
	echo "Error writing to /etc/apache2/httpd.conf"
fi
# write default sites to server
DELICION80="<VirtualHost *:80>\n\tServerAdmin webmaster@kajohansen.net\n\tDocumentRoot /var/www/delicion\n\tServerName delicion.no\n\tDirectoryIndex index.html index.php\n\tErrorLog /var/log/apache2/error.log\n\tCustomLog /var/log/apache2/access.log common\n\n\t<Directory '/var/www/delicion'>\n\t\tOptions None\n\t\tAllowOverride ALL\n\t\tOrder allow,deny\n\t\tAllow from all\n\t</Directory>\n\n\tServerAlias www.delicion.no\n</VirtualHost>"
if sudo mkdir /var/www/delicion && sudo chown -R superuser:superuser /var/www/delicion ; then
	echo "/var/www/delicion created and owner changed"
else
	echo "Error creating /var/www/delicion"
	exit 1
fi
if sudo touch /etc/apache2/sites-enabled/80_delicion_no.conf ; then
	if sudo echo -e $DELICION80 | sudo tee -a /etc/apache2/sites-enabled/80_delicion_no.conf ; then
		echo "80_delicion_no.conf created successfully"
	else
		echo "Error writing to /etc/apache2/sites-enabled/80_delicion_no.conf"
		exit 1
	fi
else
	echo "error creating 80_delicion_no.conf file"
fi

KAJOHANSEN80="<VirtualHost *:80>\n\tServerAdmin postmaster@kajohansen.com\n\tDocumentRoot /var/www/kajohansen\n\tServerName kajohansen.com\n\tDirectoryIndex index.html index.php\n\tErrorLog /var/log/apache2/error.log\n\tCustomLog /var/log/apache2/access.log common\n\n\t<Directory '/var/www/kajohansen'>\n\t\tOptions None\n\t\tAllowOverride ALL\n\t\tOrder allow,deny\n\t\tAllow from all\n\t</Directory>\n\n\tServerAlias www.kajohansen.com\n</VirtualHost>"
if sudo mkdir /var/www/kajohansen && sudo chown -R superuser:superuser /var/www/kajohansen ; then
  echo "/var/www/delicion created and owner changed"
else
	echo "Error creating /var/www/delicion"
	exit 1
fi
if sudo touch /etc/apache2/sites-enabled/80_kajohansen_com.conf ; then
  if sudo echo -e $KAJOHANSEN80 | sudo tee -a /etc/apache2/sites-enabled/80_kajohansen_com.conf ; then
		echo "80_kajohansen_com.conf created successfully"
	else
		echo "Error writing to /etc/apache2/sites-enabled/80_kajohansen_com.conf"
		exit 1
	fi
else
	echo "error creating 80_kajohansen_com.conf file"
fi
MSERVE80="<VirtualHost *:80>\n\tServerAdmin webmaster@kajohansen.com\n\tDocumentRoot /var/www/html\n\t<Directory />\n\t\tOptions FollowSymLinks\n\t\tAllowOverride None\n\t</Directory>\n\n\t<Directory /var/www/html/>\n\t\tOptions Indexes FollowSymLinks MultiViews\n\t\tAllowOverride None\n\t\tOrder allow,deny\n\t\tallow from all\n\t</Directory>\n\n\tScriptAlias /cgi-bin/ /usr/lib/cgi-bin/\n\t<Directory '/usr/lib/cgi-bin'>\n\t\tAllowOverride None\n\t\tOptions +ExecCGI -MultiViews +SymLinksIfOwnerMatch\n\t\tOrder allow,deny\n\t\tAllow from all\n\t</Directory>\n\n\tErrorLog /var/log/apache2/error.log\n\n\t# Possible values include: debug, info, notice, warn, error, crit,\n\t# alert, emerg.\n\tLogLevel warn\n\tCustomLog /var/log/apache2/access.log combined\n\tAlias /doc/ '/usr/share/doc/'\n\n\t<Directory '/usr/share/doc/'>\n\t\tOptions Indexes MultiViews FollowSymLinks\n\t\tAllowOverride None\n\t\tOrder deny,allow\n\t\tDeny from all\n\t\tAllow from 127.0.0.0/255.0.0.0 ::1/128\n\t</Directory>\n</VirtualHost>"
if sudo touch /etc/apache2/sites-enabled/80_mserve_kajohansen_com.conf ; then
  if sudo echo -e $MSERVE80 | sudo tee -a /etc/apache2/sites-enabled/80_mserve_kajohansen_com.conf ; then
	    echo "80_mserve_kajohansen_com.conf created successfully"
	else
			echo "Error writing to /etc/apache2/sites-enabled/80_mserve_kajohansen_com.conf"
			exit 1
	fi
else
	echo "error creating 80_mserve_kajohansen_com.conf file"
fi

# write default ssl sites to server
DELICION443="<VirtualHost *:443>\n\tServerAdmin webmaster@delicion.no\n\tDocumentRoot /var/www/delicion\n\tServerName delicion.no\n\tDirectoryIndex index.html index.php\n\tErrorLog /var/log/apache2/error.log\n\tCustomLog /var/log/apache2/access.log common\n\n\t<Directory '/var/www/delicion'>\n\t\tOptions None\n\t\tAllowOverride ALL\n\t\tOrder allow,deny\n\t\tAllow from all\n\t</Directory>\n\n\t<IfModule mod_ssl.c>\n\t\tSSLEngine On\n\t\tSSLCipherSuite 'ALL:!aNULL:!ADH:!eNULL:!LOW:!EXP:RC4+RSA:+HIGH:+MEDIUM'\n\t\tSSLProtocol -ALL +SSLv3 +TLSv1\n\t\tSSLProxyEngine On\n\t\tSSLCertificateFile '/etc/ssl/my_certs/delicion_no.crt'\n\t\tSSLCertificateKeyFile '/etc/ssl/my_certs/delicion_no.key'\n\t\tSSLCACertificateFile '/etc/ssl/my_certs/PositiveSSLCA2.crt'\n\t\tSSLProxyProtocol -ALL +SSLv3 +TLSv1\n\t</IfModule>\n\n\tServerAlias www.delicion.no\n</VirtualHost>"
if sudo touch /etc/apache2/sites-enabled/443_delicion_no.conf ; then
  if sudo echo -e $DELICION443 | sudo tee -a /etc/apache2/sites-enabled/443_delicion_no.conf ; then
     echo "443_delicion_no.conf created successfully"
 else
     echo "Error writing to /etc/apache2/sites-enabled/443_delicion_no.conf"
     exit 1
 fi
else
 echo "error creating 443_delicion_no.conf file"
fi
KAJOHANSEN443="<VirtualHost *:443>\n\tServerAdmin webmaster@kajohansen.com\n\tDocumentRoot /var/www/kajohansen\n\tServerName kajohansen.com\n\tDirectoryIndex index.html index.php\n\tErrorLog /var/log/apache2/error.log\n\tCustomLog /var/log/apache2/access.log common\n\n\t<Directory '/var/www/kajohansen'>\n\t\tOptions None\n\t\tAllowOverride ALL\n\t\tOrder allow,deny\n\t\tAllow from all\n\t</Directory>\n\n\t<IfModule mod_ssl.c>\n\t\tSSLEngine On\n\t\tSSLCipherSuite 'ALL:!aNULL:!ADH:!eNULL:!LOW:!EXP:RC4+RSA:+HIGH:+MEDIUM'\n\t\tSSLProtocol -ALL +SSLv3 +TLSv1\n\t\tSSLProxyEngine On\n\t\tSSLCertificateFile '/etc/ssl/my_certs/kajohansen_com.crt'\n\t\tSSLCertificateKeyFile '/etc/ssl/my_certs/kajohansen_com.key'\n\t\tSSLCACertificateFile '/etc/ssl/my_certs/PositiveSSLCA2.crt'\n\t\tSSLProxyProtocol -ALL +SSLv3 +TLSv1\n\t</IfModule>\n\n\tServerAlias www.kajohansen.com\n</VirtualHost>"
if sudo touch /etc/apache2/sites-enabled/443_kajohansen_com.conf ; then
  if sudo echo -e $KAJOHANSEN443 | sudo tee -a /etc/apache2/sites-enabled/443_kajohansen_com.conf ; then
     echo "443_kajohansen_com.conf created successfully"
 else
     echo "Error writing to /etc/apache2/sites-enabled/443_kajohansen_com.conf"
     exit 1
 fi
else
 echo "error creating 443_kajohansen_com.conf file"
fi
MSERVE443="<VirtualHost *:443>\n\tServerAdmin webmaster@kajohansen.com\n\tDocumentRoot /var/www/html\n\tServerName mserve.kajohansen.com\n\tDirectoryIndex index.html index.php\n\tErrorLog /var/log/apache2/error.log\n\tCustomLog /var/log/apache2/access.log common\n\n\t<Directory '/var/www/html'>\n\t\tOptions None\n\t\tAllowOverride ALL\n\t\tOrder allow,deny\n\t\tAllow from all\n\t\t</Directory>\n\n\t<IfModule mod_ssl.c>\n\t\tSSLEngine On\n\t\tSSLCipherSuite 'ALL:!aNULL:!ADH:!eNULL:!LOW:!EXP:RC4+RSA:+HIGH:+MEDIUM'\n\t\tSSLProtocol -ALL +SSLv3 +TLSv1\n\t\tSSLProxyEngine On\n\t\tSSLCertificateFile '/etc/ssl/my_certs/mserve_kajohansen_com.crt'\n\t\tSSLCertificateKeyFile '/etc/ssl/my_certs/mserve_kajohansen_com.key'\n\t\tSSLCACertificateFile '/etc/ssl/my_certs/PositiveSSLCA2.crt'\n\t\tSSLProxyProtocol -ALL +SSLv3 +TLSv1\n\t</IfModule>\n\n\tServerAlias www.mserve.kajohansen.com\n</VirtualHost>"
if sudo touch /etc/apache2/sites-enabled/443_mserve_kajohansen_com.conf ; then
  if sudo echo -e $MSERVE443 | sudo tee -a /etc/apache2/sites-enabled/443_mserve_kajohansen_com.conf ; then
     echo "443_mserve_kajohansen_com.conf created successfully"
 else
     echo "Error writing to /etc/apache2/sites-enabled/443_mserve_kajohansen_com.conf"
     exit 1
 fi
else
 echo "error creating 443_mserve_kajohansen_com.conf file"
fi
