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
  Optional[String] $request_header = undef,
  String $ds_password     = $vision_freeipa::ds_password,
  String $realm           = $vision_freeipa::realm,

) {

  contain ::vision_gluster::node

  contain ::vision_freeipa::master::config
  contain ::vision_freeipa::master::docker

}
