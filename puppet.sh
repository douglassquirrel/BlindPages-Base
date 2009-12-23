echo "BLINDPAGES: Installing puppet"
sudo apt-get install puppet
echo "BLINDPAGES: Done installing puppet"

echo "BLINDPAGES: Testing puppet"
puppet puppet-min.pp
echo "BLINDPAGES: Test complete (should have printed 'hello world')"

echo "BLINDPAGES: Copying files"
sudo mkdir /etc/puppet/manifests
sudo mkdir /etc/puppet/manifests/classes
sudo cp sudo.pp /etc/puppet/manifests/classes
sudo cp site.pp /etc/puppet/manifests
echo "BLINDPAGES: Files copied"

echo "BLINDPAGES: Running puppet basic recipe"
cd /etc/puppet && puppet --parseonly /etc/puppet/manifests/site.pp
cd /etc/puppet && puppet --noop /etc/puppet/manifests/site.pp   --debug
cd /etc/puppet && puppet /etc/puppet/manifests/site.pp
echo "BLINDPAGES: Puppet basic recipe finished"
