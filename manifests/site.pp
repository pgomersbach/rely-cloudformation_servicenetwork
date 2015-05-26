if versioncmp($::puppetversion,'3.6.1') >= 0 {
  $allow_virtual_packages = hiera('allow_virtual_packages',false)
  Package {
    allow_virtual => $allow_virtual_packages,
  }
}

node default {
  if $tag_role != undef {
    $role=$tag_role
  }
  elsif $ec2_security_groups != undef {
    $role=$ec2_security_groups
  }
  else {
    $role= regsubst($hostname,'(^[A-Za-z][A-Za-z]*)')
  }
  include "role_${role}"
}
