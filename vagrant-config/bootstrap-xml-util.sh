cd /tmp
sudo apt-get update -y
sudo apt-get install -y git
sudo apt-get install -y make
sudo apt-get install -y g++
sudo apt-get install -y maven

sudo apt-get install -y openjdk-7-jdk

if [ ! -d "/vagrant/project" ]; then 
	mkdir /vagrant/project
fi
cd /vagrant/project
if [ -d "xml-util" ]; then 
	sudo rm -r xml-util
fi
# mkdir xml-util
git clone https://github.com/usnistgov/xml-util.git xml-util

sudo apt-get install -y curl
# sudo apt-get remove scala-library scala
# sudo wget www.scala-lang.org/files/archive/scala-2.11.7.deb
# sudo dpkg -i scala-2.11.7.deb
sudo apt-get update
sudo apt-get install -y scala

# wget http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt/0.13.1/sbt.deb
# sudo dpkg -i sbt.deb
sudo echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-get update
sudo apt-get install -y --force-yes sbt

sudo cp /vagrant/vagrant-ressources/.nexusCredentials /home/vagrant
sudo chmod 755 /home/vagrant/.nexusCredentials

# sudo rm -r /vagrant/project/xml-util
# git clone https://github.com/usnistgov/xml-util.git /vagrant/project/xml-util

echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> /home/vagrant/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /home/vagrant/.bashrc
echo "export MAVEN_OPTS=\"-Dmaven.repo.local=/vagrant/.m2\"" >> /home/vagrant/.bashrc
echo "export SBT_OPTS=\"\$SBT_OPTS -Dsbt.ivy.home=/vagrant/.ivy2 -Divy.home=/vagrant/.ivy2\"" >> /home/vagrant/.bashrc