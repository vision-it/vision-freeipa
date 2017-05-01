# Class: vision_freeipa
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

class vision_freeipa::config (

  String $realm          = $vision_freeipa::realm,
  String $ds_password    = $vision_freeipa::ds_password,
  String $admin_password = $vision_freeipa::admin_password,

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
