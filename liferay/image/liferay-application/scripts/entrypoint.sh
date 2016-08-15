#!/bin/bash
echo "Starting Liferay Application Container!"

file="/opt/liferay/setup.done"
tomcat="tomcat-7.0.62"

#Config
if [[ ! -f "$file" ]]; then
    
cat << EOF > $file
Liferay 0.0.1 installed
EOF

sed -i "s/DATABASEPASSWORD/${POSTGRES_PASSWORD}/g" /conf/portal-setup-wizard.properties
ln /conf/portal-setup-wizard.properties /opt/liferay/portal-setup-wizard.properties

sed -i "s/TOMCAT_INSTANCE_VERSION_NUMBER/$tomcat/g" /conf/liferay
ln /conf/liferay /etc/init.d/liferay

chown -r liferay:liferay /opt/liferay
chmod +x /etc/init.d/functions
chmod +x /etc/init.d/liferay

fi

#Startu Up
service liferay start
tail -f /opt/liferay/$tomcat/logs/catalina.out