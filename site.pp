# /etc/puppet/manifests/site.pp

import "classes/*"

node default {
    include sudo
}

