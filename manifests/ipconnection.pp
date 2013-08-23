# 'present' =(present|absent)
# 'type' is e.g. 'syslog' or 'dns'
# 'port' can be 'any' for every port
define ipsec::ipconnection (
  $present,
  $fqdn,
  $sourceip,
  $destip,
  $type,
  $port,
) { 

  @@Ip_connection { ## Defaults
      ensure      => "$present",
      servicetype => "${type}",
      sourceip    => "$sourceip",
      destip      => "$destip",
      port        => "$port",
      require     => [
        Package["ipsec-tools"],
        File["setkey.conf"],
        Service["racoon"],
        ],
  }

  @@ip_connection {
    "${sourceip}_${type}_out":
      alias => "${fqdn}_${type}_out",

    "${sourceip}_${type}_in":
      alias => "${fqdn}_${type}_in",
  }
}

