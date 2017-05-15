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

  file { ['/data', '/data/ipa']:
    ensure  => directory,
  }

  file { '/data/ipa/ipa-server-install-options':
    ensure  => present,
    content => template('vision_freeipa/ipa-server-install-options.erb'),
    require => File['/data/ipa'],
  }

}
