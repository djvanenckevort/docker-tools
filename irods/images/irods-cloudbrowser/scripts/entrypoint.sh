#!/bin/bash
file="/etc/irods-cloud-backend-config.groovy"

##Setup
if [[ ! -f "$file" ]]; then
#Add Proxy
/opt/script/addproxy.sh -t irods-cloud-backend -s ${CLOUD_BACKEND_SUBDOMAIN} -p ${CLOUD_BACKEND_PORT} -u ${CLOUD_BACKEND_URL} -i ${CLOUD_BACKEND_IP}
sed -i 's/location.hostname+":8080/${CLOUD_BACKEND_SUBDOMAIN}.${CLOUD_BACKEND_URL}/g' /var/www/html/app/components/
service apache2 restart
sed -i "s/beconf.login.preset.host='localhost'/beconf.login.preset.host='${IRODS_HOST_URL}'" /opt/install/irods-cloud-backend-config.groovy
mv /opt/install/irods-cloud-backend-config.groovy /etc/irods-cloud-backend-config.groovy
fi 

##RUN
#Run Tomcat if not running
service=tomcat7
if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
echo "$service is running!!!"
else
/etc/init.d/$service start
fi

#Run Apache if not running
service=apache2
if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
echo "$service is running!!!"
else
/etc/init.d/$service start
fi