#!/bin/bash
die() {
  echo $1
  exit 1
}

if [ "$(whoami)" != 'root' ]; then
   die "BLINDPAGES: This script must be run as root" 1>&2
fi

rm -f /var/tmp/mysql-server-5.0-preseed

#read -p "Please enter desired MySQL root password: " rootpassword
#read -p "Please enter desired MySQL blindpages password: " blindpagespassword

echo "BLINDPAGES: Installing puppet"
apt-get -y install puppet
echo "BLINDPAGES: Done installing puppet"

echo "BLINDPAGES: Testing puppet"
puppet puppet-min.pp
echo "BLINDPAGES: Test complete (should have printed 'hello world')"

echo "BLINDPAGES: Setting up files"
mkdir /etc/puppet/manifests
mkdir /etc/puppet/modules
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

#echo "BLINDPAGES: Running mysql setup script"
#./mysql.sh $rootpassword $blindpagespassword
#echo "BLINDPAGES: Done setting up mysql"
