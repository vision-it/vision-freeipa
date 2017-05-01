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

class vision_freeipa (

  String $realm,
  String $ds_password,
  String $admin_password,

) {

  contain ::vision_docker
  contain ::vision_freeipa::images
  contain ::vision_freeipa::config
  contain ::vision_freeipa::run

  # Order of execution
  Class['::vision_docker']
  -> Class['::vision_freeipa::images']
  -> Class['::vision_freeipa::config']
  ~> Class['::vision_freeipa::run']

}
