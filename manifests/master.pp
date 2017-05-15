# Class: vision_freeipa::master
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_freeipa::master
#

class vision_freeipa::master (

  String $admin_password,
  String $ds_password     = $vision_freeipa::ds_password,
  String $realm           = $vision_freeipa::realm,

) {

  contain ::vision_docker
  contain ::vision_freeipa::images
  contain ::vision_freeipa::master::config
  contain ::vision_freeipa::master::run

  # Order of execution
  Class['::vision_docker']
  -> Class['::vision_freeipa::images']
  -> Class['::vision_freeipa::master::config']
  ~> Class['::vision_freeipa::master::run']

}
