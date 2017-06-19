# Class: vision_freeipa::replica
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_freeipa::replica
#

class vision_freeipa::replica (

  String $admin_password,
  String $master_hostname,

  String $master_realm = $vision_freeipa::realm,
  String $ds_password  = $vision_freeipa::ds_password,

) {

  contain ::vision_docker
  contain ::vision_freeipa::images
  contain ::vision_freeipa::replica::config
  contain ::vision_freeipa::replica::run

  # Order of execution
  Class['::vision_docker']
  -> Class['::vision_freeipa::images']
  -> Class['::vision_freeipa::replica::config']
  ~> Class['::vision_freeipa::replica::run']

}
