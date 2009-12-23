if [ "$(whoami)" != 'root' ]; then
   echo "BLINDPAGES: This script must be run as root" 1>&2
   exit 1
fi

echo "BLINDPAGES: Installing puppet"
apt-get install puppet
echo "BLINDPAGES: Done installing puppet"

echo "BLINDPAGES: Testing puppet"
puppet puppet-min.pp
echo "BLINDPAGES: Test complete (should have printed 'hello world')"

echo "BLINDPAGES: Setting up files"
mkdir /etc/puppet/manifests
cp -Rv manifests/* /etc/puppet/manifests
echo "BLINDPAGES: Files copied"

echo "BLINDPAGES: Running puppet "
puppet --parseonly /etc/puppet/manifests/site.pp
puppet --noop /etc/puppet/manifests/site.pp   --debug
puppet /etc/puppet/manifests/site.pp
echo "BLINDPAGES: Puppet finished"
