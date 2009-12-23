# /etc/puppet/manifests/site.pp

Service {
 provider => debian
}

import "modules"
import "nodes"
