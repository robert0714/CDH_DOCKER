#!/bin/bash
# centos 7.6
value=$( grep -ic "entry" /etc/hosts )
if [ $value -eq 0 ]
then
echo "
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
################ cdh-cookbook host entry ############
107.70.38.211  gfcdh1.iead.local	gfcdh1
107.70.38.212  gfcdh2.iead.local	gfcdh2
107.70.38.213  gfcdh3.iead.local	gfcdh3
######################################################
" > /etc/hosts
fi

# 新增額外repo
sudo wget https://archive.cloudera.com/cm6/6.1.1/redhat7/yum/cloudera-manager.repo -P /etc/yum.repos.d/
sudo rpm --import https://archive.cloudera.com/cm6/6.1.1/redhat7/yum/RPM-GPG-KEY-cloudera
sudo wget https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum install pgdg-redhat-repo-latest.noarch.rpm epel-release -y

# 下載開發工具與函示庫
sudo yum groupinstall "Compatibility Libraries" -y
sudo yum groupinstall "Development Tools" -y 
sudo yum install ntp -y

# 下載Cloudera相關套件
sudo yum install  -y  oracle-j2sdk1.8
sudo yum install -y   cloudera-manager-daemons cloudera-manager-agent cloudera-manager-server 

# java (請自行設定路徑) 
sudo echo 'export JAVA_HOME=/usr/java/jdk1.8.0_181-cloudera' >> /etc/profile
sudo echo 'export CLASSPATH=.:$CLASSPTAH:$JAVA_HOME/lib' >> /etc/profile
sudo echo 'export PATH=$PATH:$JAVA_HOME/bin' >> /etc/profile
sudo source /etc/profile

# ntp (請自行設定路徑)
sudo systemctl stop ntpd
sudo sed -e "s/server 0.rhel.pool.ntp.org iburst/server gfcdh1.iead.local/" -i /etc/ntp.conf
sudo sed -e 's/server 1.rhel.pool.ntp.org iburst/#server 1.rhel.pool.ntp.org iburst/' -i /etc/ntp.conf
sudo sed -e 's/server 2.rhel.pool.ntp.org iburst/#server 2.rhel.pool.ntp.org iburst/' -i /etc/ntp.conf
sudo sed -e 's/server 3.rhel.pool.ntp.org iburst/#server 3.rhel.pool.ntp.org iburst/' -i /etc/ntp.conf
sudo systemctl start ntpd
sudo systemctl enable ntpd

# 複製jdbc
sudo  mkdir  -p /usr/share/java/
sudo  cd  /usr/share/java/
sudo  wget https://repo1.maven.org/maven2/org/postgresql/postgresql/42.2.8/postgresql-42.2.8.jar
 
sudo  ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa
sudo  sh -c  "cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys"
# Prevent ssh setup questions
sudo sh -c  "printf 'NoHostAuthenticationForLocalhost yes
 Host *  
    StrictHostKeyChecking no' > /root/.ssh/config"
