# Class: vision_freeipa::replica::config
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_freeipa::replica::config
#

class vision_freeipa::replica::config (

  String $ds_password     = $vision_freeipa::replica::ds_password,
  String $admin_password  = $vision_freeipa::replica::admin_password,
  String $master_hostname = $vision_freeipa::replica::master_hostname,
  String $master_domain   = $vision_freeipa::replica::master_domain,

) {

  file { ['/data', '/data/ipa']:
    ensure  => directory,
  }

  file { '/data/ipa/ipa-replica-install-options':
    ensure  => present,
    content => template('vision_freeipa/ipa-replica-install-options.erb'),
    require => File['/data/ipa'],
  }

}
