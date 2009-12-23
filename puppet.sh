echo "BLINDPAGES: Installing puppet"
sudo apt-get install puppet
echo "BLINDPAGES: Done installing puppet"

echo "BLINDPAGES: Testing puppet"
puppet puppet-min.pp
echo "BLINDPAGES: Test complete (should have printed 'hello world')"

echo "BLINDPAGES: Copying files"
cp sudo.pp /etc/puppet/manifests/classes
cp site.pp /etc/puppet/manifests
echo "BLINDPAGES: Files copied"

echo "BLINDPAGES: Starting puppetmaster"
sudo /etc/init.d/puppetmaster restart
echo "BLINDPAGES: puppetmaster started"

echo "BLINDPAGES: Running client"
sudo puppetd --verbose
sudo puppetca --list
sudo puppetca --sign foo
echo "BLINDPAGES: Client finished"
