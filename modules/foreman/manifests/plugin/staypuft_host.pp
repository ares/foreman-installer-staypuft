# = Staypuft Hostname
#
# === Parameters:
#
# $fqdn::                  FQDN of a host to configure
#
# $ip::                  IP address matching the FQDN
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
