# = Staypuft Hostname
#
# === Parameters:
#
# $interface::            Which interface should this class configure
#
# $ip::                   What IP address should be set
#
# $netmask::              What netmask should be set
#
# $gateway::              What is the gateway for this machine
#
# $dns::                  DNS forwarder to use as secondary nameserver
#
# $configure_networking:: Should we modify networking?
#                         type:boolean
#
# $configure_firewall::   Should we modify firewall?
#                         type:boolean
#
class foreman::plugin::staypuft_host(
    $fqdn,
    $ip,
) {

    $host_name = regsubst($fqdn,'^([^\.]+)','\1')

    # persist and set the hostname
    file_line { 'persist HOSTNAME':
      path  => '/etc/sysconfig/network',
      line  => "HOSTNAME=$fqdn",
      match => '^HOSTNAME.*',
    }
    exec { "set-hostname":
      command => "/bin/hostname $fqdn",
    }

    host { $fqdn:
      comment      => 'created by puppet class foreman::plugin::staypuft_network',
      ip           => $ip,
      host_aliases => $host_name,
    }


}
