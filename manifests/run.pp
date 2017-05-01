# Class: vision_freeipa::run
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_freeipa
#

class vision_freeipa::run (

  Array  $environment = [],
  String $hostname    = $::fqdn,
  String $version     = 'latest',
  String $ipaddress_eth1 = $::ipaddress_eth1,

) {

  $docker_environment = concat([
    "IPA_SERVER_IP=${ipaddress_eth1}"
  ], $environment)

  ::docker::run { 'freeipa':
    image            => "freeipa/freeipa-server:${version}",
    volumes          => [
      '/data/ipa:/data:Z',
      '/sys/fs/cgroup:/sys/fs/cgroup:ro',
    ],
    hostname         => $hostname,
    env              => $docker_environment,
    ports            => [
      '80:80',
      '443:443',
      '88:88/tcp',
      '88:88/udp',
      '389:389',
      '636:636',
      '7389:7389',
      '123:123',
      '9443:9443',
      '9444:9444',
      '9445:9445',
    ],
    extra_parameters => [ '--tmpfs /tmp', '--tmpfs /run' ],
  }

}
