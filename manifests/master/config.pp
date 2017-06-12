# Class: vision_freeipa::master::config
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_freeipa::master::config
#

class vision_freeipa::master::config (

  String $realm          = $vision_freeipa::master::realm,
  String $ds_password    = $vision_freeipa::master::ds_password,
  String $admin_password = $vision_freeipa::master::admin_password,

) {

  file { ['/data',
          '/data/ipa',
          '/data/ipa/etc',
          '/data/ipa/etc/httpd',
          '/data/ipa/etc/httpd/conf.d',
  ]:
    ensure  => directory,
  }

  file { '/data/ipa/ipa-server-install-options':
    ensure  => present,
    content => template('vision_freeipa/ipa-server-install-options.erb'),
    require => File['/data/ipa'],
  }

  file { '/data/ipa/etc/httpd/conf.d/ipa-rewrite.conf':
    ensure  => present,
    content => file('vision_freeipa/ipa-rewrite.conf'),
    require => File['/data/ipa/etc/httpd/conf.d'],
  }

}
