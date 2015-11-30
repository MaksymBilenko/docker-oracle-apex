#!/bin/bash

unzip /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /
unzip /tmp/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip -d /

SQLPLUS=/instantclient_12_1/sqlplus
SQLPLUS_ARGS="${USER}/${PASS}@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=${HOST})(Port=${PORT}))(CONNECT_DATA=(SID=${SID}))) as sysdba"

verify(){
	echo "exit" | ${SQLPLUS} -L $SQLPLUS_ARGS | grep Connected > /dev/null
	if [ $? -eq 0 ];
	then
	   echo "Database Connetion is OK"
	else
	   echo -e "Database Connection Failed. Connection failed with:\n $SQLPLUS -S $SQLPLUS_ARGS\n `$SQLPLUS -S $SQLPLUS_ARGS` < /dev/null"
	   echo -e "run example:\n docker run -it --rm --volumes-from $oracle_db_name:oracle-database --link $oracle_db_name:oracle-database sath89/apex install"
	   exit 1
	fi

	if [ "$(ls -A /u01/app/oracle)" ]; then
		echo "Check Database files folder: OK"
	else
		echo -e "Failed to find database files, run example:\n docker run -it --rm --volumes-from $oracle_db_name:oracle-database --link $oracle_db_name:oracle-database sath89/apex install"
		exit 1
	fi
}

disable_http(){
	echo "Turning off DBMS_XDB HTTP port"
	echo "EXEC DBMS_XDB.SETHTTPPORT(0);" | $SQLPLUS -S $SQLPLUS_ARGS
}

enable_http(){
	echo "Turning on DBMS_XDB HTTP port"
	echo "EXEC DBMS_XDB.SETHTTPPORT($HTTP_PORT);" | $SQLPLUS -S $SQLPLUS_ARGS
}

get_oracle_home(){
	echo "Getting ORACLE_HOME Path"
	ORACLE_HOME=`echo -e "var ORACLEHOME varchar2(200);\n EXEC dbms_system.get_env('ORACLE_HOME', :ORACLEHOME);\n PRINT ORACLEHOME;" | $SQLPLUS -S $SQLPLUS_ARGS | grep "/.*/"`
	echo "ORACLE_HOME found: $ORACLE_HOME"
}

apex_epg_config(){
	cd /u01/app/oracle/apex
	#get_oracle_home
	echo "Setting up EPG for Apex by running: @apex_epg_config $ORACLE_HOME"
	$SQLPLUS -S $SQLPLUS_ARGS @apex_epg_config /u01/app/oracle < /dev/null
}

apex_upgrade(){
	cd /u01/app/oracle/apex
	echo "Upgrading apex..."
	$SQLPLUS -S $SQLPLUS_ARGS @apexins SYSAUX SYSAUX TEMP /i/ < /dev/null
	echo "Updating apex images"
	$SQLPLUS -S $SQLPLUS_ARGS @apxldimg.sql /u01/app/oracle < /dev/null
	#Cleanup after run
	cd /
	rm -rf /u01/app/oracle/apex
}

unzip_apex(){
	echo "Extracting Apex-${APEX_VERSION}"
	cat /apex_${APEX_VERSION}/apex_${APEX_VERSION}.zip-aa > /tmp/apex.zip
	cat /apex_${APEX_VERSION}/apex_${APEX_VERSION}.zip-ab >> /tmp/apex.zip
	rm -rf /u01/app/oracle/apex
	unzip /tmp/apex.zip -d /u01/app/oracle/
	rm -f /tmp/apex.zip
}


case $1 in
	'install')
		verify
		unzip_apex
		disable_http
		apex_upgrade
		apex_epg_config
		enable_http
		;;
	*)
		$1
		;;
esac