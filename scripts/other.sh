

sudo  yum install epel-release -y
sudo  yum install -y java-1.8.0-openjdk  java-1.8.0-openjdk-devel 
sudo ln -s  /usr/lib/jvm/java-1.8.0-openjdk  /usr/lib/jvm/jdk

sudo sh -c 'echo export JAVA_HOME=/usr/lib/jvm/jdk/ >> /home/hduser/.bashrc'

# Add hadoop user
sudo groupadd hadoop
sudo useradd -g hadoop hduser
echo hduser:hduser | sudo chpasswd
sudo adduser hduser sudo

sudo -u hduser ssh-keygen -t rsa -P '' -f /home/hduser/.ssh/id_rsa
sudo sh -c  "cat /home/hduser/.ssh/id_rsa.pub >> /home/hduser/.ssh/authorized_keys"
# Prevent ssh setup questions
sudo sh -c  "printf 'NoHostAuthenticationForLocalhost yes
 Host *  
    StrictHostKeyChecking no' > /home/hduser/.ssh/config"

# Download Scala to the vagrant shared directory if it doesn't exist yet
cd /vagrant
if [ ! -f scala-2.11.12.tgz ]; then
	wget https://www.scala-lang.org/files/archive/scala-2.11.12.tgz
fi
# Unpack Scala and install
sudo tar vxzf scala-2.11.12.tgz -C /usr/local
cd /usr/local
sudo mv scala-2.11.12 scala
sudo chown -R hduser:hadoop scala

# scala variables
sudo sh -c 'echo export SCALA_HOME=/usr/local/scala >> /home/hduser/.bashrc'
sudo sh -c 'echo export PATH=\$PATH:\$SCALA_HOME/bin >> /home/hduser/.bashrc'
sudo yum install -y -q sbt   screen  lsof  yum-utils
cat /etc/*release
sudo yum install -y -q epel-release
sudo rpm -U --quiet http://mirrors.kernel.org/fedora-epel/6/i386/epel-release-6-8.noarch.rpm
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
sudo yum repolist
sudo yum install -y -q p7zip p7zip-plugins

