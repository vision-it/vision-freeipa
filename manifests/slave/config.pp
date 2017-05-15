# Class: vision_freeipa::slave::config
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_freeipa::slave::config
#

class vision_freeipa::slave::config (

  String $ds_password     = $vision_freeipa::slave::ds_password,
  String $admin_password  = $vision_freeipa::slave::admin_password,
  String $master_hostname = $vision_freeipa::slave::master_hostname,
  String $master_domain   = $vision_freeipa::slave::master_domain,

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
