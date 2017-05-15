# Class: vision_freeipa::slave
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_freeipa::slave
#

class vision_freeipa::slave (

  String $admin_password,
  String $master_hostname,
  String $master_domain,
  String $ds_password     = $vision_freeipa::ds_password,

) {

  contain ::vision_docker
  contain ::vision_freeipa::images
  contain ::vision_freeipa::slave::config
  contain ::vision_freeipa::slave::run

  # Order of execution
  Class['::vision_docker']
  -> Class['::vision_freeipa::images']
  -> Class['::vision_freeipa::slave::config']
  ~> Class['::vision_freeipa::slave::run']

}
