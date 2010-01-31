#!/bin/bash

function log() {
  echo `date` "$1"
}

die() {
  echo $1
  exit 1
}

if [ "$(whoami)" != 'root' ]; then
   die "This script must be run as root" 1>&2
fi

log "Doing MySQL setup"
rm -f /var/tmp/mysql-server-5.0-preseed
read -p "Please enter desired MySQL root password: " rootpassword
read -p "Please enter desired MySQL blindpages password: " blindpagespassword
log "Done with MySQL setup"

log "Updating ubuntu repository"
apt-get update
log "Done updating repository"

log "Installing build tools, rubygems, and giternal"
apt-get -y install build-essential ruby1.8 rdoc1.8 ruby1.8-dev libopenssl-ruby 
dpkg -i packages/giternal.deb packages/rubygems1.8_1.3.5-1ubuntu2_all.deb packages/rubygems_1.3.5-1ubuntu2_all.deb
apt-get -y -f install
log "Done installing"

log "Getting puppet modules"
giternal update
log "Done getting puppet modules"

if type -P puppet &>/dev/null && type -P facter &>/dev/null; then
    log "Facter and puppet already installed"
else
    log "Downloading and unpacking facter and puppet"
    wget http://reductivelabs.com/downloads/puppet/puppet-0.24.8.tgz
    gzip -d -c puppet-0.24.8.tgz | tar xfm -
    wget http://reductivelabs.com/downloads/facter/facter-1.5.4.tgz
    gzip -d -c facter-1.5.4.tgz | tar xfm -
    log "Done downloading and unpacking facter and puppet"

    log "Installing facter"
    cd facter-*
    ruby install.rb
    cd ..
    log "Done installing facter"

    log "Installing puppet"
    #apt-get -y install puppet
    cd puppet-*
    ruby install.rb
    cd ..
    log "Done installing puppet"
fi

log "Testing puppet"
puppet puppet_min.pp
log "Test complete (should have printed 'hello world')"

log "Setting up files"
mkdir -p /etc/puppet/manifests
mkdir -p /etc/puppet/modules
mkdir -p /var/puppet
cp -Rv manifests/* /etc/puppet/manifests
cp -Rv modules/* /etc/puppet/modules
log "Files copied"

puppet_args="--templatedir /etc/puppet/templates"

log "Running puppet in parseonly mode"
puppet --parseonly ${puppet_args} /etc/puppet/manifests/site.pp || die "puppet's not valid"
log "Done in parseonly mode"

log "Running puppet"
puppet --verbose --debug ${puppet_args} /etc/puppet/manifests/site.pp
log "Puppet finished"

log "Running mysql setup script"
./mysql.sh $rootpassword $blindpagespassword
log "Done setting up mysql"
