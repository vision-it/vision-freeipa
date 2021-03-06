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

  Optional[String] $request_header = $vision_freeipa::master::request_header

) {

  file { ['/vision/data/ipa',
          '/vision/data/ipa/etc',
          '/vision/data/ipa/etc/httpd',
          '/vision/data/ipa/etc/httpd/conf.d',
  ]:
    ensure  => directory,
  }

  file { '/vision/data/ipa/ipa-server-install-options':
    ensure  => present,
    content => template('vision_freeipa/ipa-server-install-options.erb'),
    require => File['/vision/data/ipa'],
  }

  file { '/vision/data/ipa/etc/httpd/conf.d/ipa-rewrite.conf':
    ensure  => present,
    content => template('vision_freeipa/ipa-rewrite.conf.erb'),
    require => File['/vision/data/ipa/etc/httpd/conf.d'],
  }

}
