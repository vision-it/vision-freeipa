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

  String $type,
  String $realm,
  String $ds_password,
  String $version,

) {

  if ($type == 'master') {
    contain vision_freeipa::master
  }

}
