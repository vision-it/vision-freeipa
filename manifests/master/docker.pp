# Class: vision_freeipa::master::run
# ===========================

class vision_freeipa::master::docker (

  String $whitelist,
  Array  $environment = [],
  String $hostname    = 'vision.fraunhofer.de',
  String $version     = $vision_freeipa::version,
  String $ipaddress   = $::ipaddress,

) {

  $docker_environment = concat([
    "IPA_SERVER_IP=${ipaddress}",
    "IPA_SERVER_HOSTNAME=${hostname}",
    # 'DEBUG_TRACE=1',
    # 'DEBUG_NO_EXIT=1',
  ], $environment)

  # options not available for docker swarm stacks
  # '--sysctl net.ipv6.conf.all.disable_ipv6=0'
  # '--cap-add SYS_TIME'

  $compose = {
    'version' => '3.7',
    'services' => {
      'freeipa' => {
        # use our own image which disables ipv6 checks
        'image'       => "visionit/freeipa-server:${version}",
        'hostname'    => $hostname,
        'volumes'     => [
          '/vision/data/ipa:/data',
          '/sys/fs/cgroup:/sys/fs/cgroup:ro',
          {
            'type'   => 'tmpfs',
            'target' => '/tmp',
            'tmpfs'  => {
              'size' => 100000000 # 100MB
            },
          },
          {
            'type'   => 'tmpfs',
            'target' => '/run',
            'tmpfs'  => {
              'size' => 50000000 # 50MB
            },
          },
        ],
        'environment' => $docker_environment,
        'ports'       => [
#          '80:80', # http
#          '443:443', # https
          '88:88/tcp', # kerberos
          '88:88/udp', # kerberos
          '389:389', # ldap
          '636:636', # ldaps
          '7389:7389', # dogtag
          '464:464/tcp', # kpasswd: kerberos change/set password
          '464:464/udp', # kpasswd: kerberos change/set password
#          '123:123', # ntp
          '9443:9443', # dogtag (agents)
          '9444:9444', # dogtag (users, SSL)
          '9445:9445', # dogtag (administrators)
        ],
        'deploy'       => {
          'labels' => [
            'traefik.enable=true',
            'traefik.http.services.ipa.loadbalancer.server.port=80',
            'traefik.http.services.ipa.loadbalancer.passHostHeader=true',
            'traefik.http.routers.ipa.rule=PathPrefix(`/ipa`)',
            'traefik.http.routers.ipa.entrypoints=https',
            'traefik.http.routers.ipa.tls=true',
            'traefik.http.routers.ipa.middlewares=whitelist-ipa@docker',
            "traefik.http.middlewares.whitelist-ipa.ipwhitelist.sourcerange=${whitelist}",
          ]
        }
      }
    }
  }
  # note: web server runs on port 80 / 443

  vision_docker::to_compose { 'freeipa-master':
    compose => $compose,
  }

}
