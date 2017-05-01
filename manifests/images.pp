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
# contain ::vision_freeipa
#

class vision_freeipa::images (

) {

  ::docker::image { 'freeipa':
    ensure    => present,
    image     => 'freeipa/freeipa-server',
    image_tag => 'latest',
  }

}
