# Class: vision_freeipa::images
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_freeipa::images
#

class vision_freeipa::images (

  String $version = $vision_freeipa::version

) {

  ::docker::image { 'freeipa':
    ensure    => present,
    image     => 'freeipa/freeipa-server',
    image_tag => $version,
  }

}
