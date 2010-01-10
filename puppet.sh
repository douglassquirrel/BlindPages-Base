#!/bin/bash

die() {
  echo $1
  exit 1
}

if [ "$(whoami)" != 'root' ]; then
   die "BLINDPAGES: This script must be run as root" 1>&2
fi

echo "BLINDPAGES: Installing rubygems and giternal"
apt-get -y install rubygems
wget http://media.build-doctor.com/giternal.deb 
dpkg -i giternal.deb
apt-get -y -f install
echo "BLINDPAGES: Done installing rubygems and giternal"

echo "BLINDPAGES: Getting puppet modules"
giternal update
echo "BLINDPAGES: Done getting puppet modules"

echo "BLINDPAGES: Doing MySQL setup"
rm -f /var/tmp/mysql-server-5.0-preseed
read -p "Please enter desired MySQL root password: " rootpassword
read -p "Please enter desired MySQL blindpages password: " blindpagespassword
echo "BLINDPAGES: Done with MySQL setup"

echo "BLINDPAGES: Downloading and unpacking facter and puppet"
wget http://reductivelabs.com/downloads/puppet/puppet-0.24.8.tgz
gzip -d -c puppet-0.24.8.tgz | tar xfm -
wget http://reductivelabs.com/downloads/facter/facter-1.5.4.tgz
gzip -d -c facter-1.5.4.tgz | tar xfm -
echo "BLINDPAGES: Done downloading and unpacking facter and puppet"

echo "BLINDPAGES: Installing facter"
cd facter-*
ruby install.rb
cd ..
echo "BLINDPAGES: Done installing facter"

echo "BLINDPAGES: Installing puppet"
#apt-get -y install puppet
cd puppet-*
ruby install.rb
cd ..
echo "BLINDPAGES: Done installing puppet"

echo "BLINDPAGES: Testing puppet"
puppet puppet_min.pp
echo "BLINDPAGES: Test complete (should have printed 'hello world')"

echo "BLINDPAGES: Setting up files"
mkdir -p /etc/puppet/manifests
mkdir -p /etc/puppet/modules
mkdir -p /var/puppet
cp -Rv manifests/* /etc/puppet/manifests
cp -Rv modules/* /etc/puppet/modules
echo "BLINDPAGES: Files copied"

puppet_args="--templatedir /etc/puppet/templates"

echo "BLINDPAGES: Running puppet in parseonly mode"
puppet --parseonly ${puppet_args} /etc/puppet/manifests/site.pp || die "puppet's not valid"
echo "BLINDPAGES: Done in parseonly mode"

echo "BLINDPAGES: Running puppet"
puppet --verbose --debug ${puppet_args} /etc/puppet/manifests/site.pp
echo "BLINDPAGES: Puppet finished"

echo "BLINDPAGES: Running mysql setup script"
./mysql.sh $rootpassword $blindpagespassword
echo "BLINDPAGES: Done setting up mysql"
