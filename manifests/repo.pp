#
# == Class: beats::repo
#
# Install the appropriate Beats package repository.
#
# === Example usage
#
#  This class should not be instantiated directly.
#
class beats::repo {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  case $::osfamily {
    'Debian': {
      class { 'beats::repo::apt': }
    }

    'RedHat': {
      class { 'beats::repo::yum': }
    }

    # intentionally no default case - unsupported OS triggers a catalogue
    # failure in init.pp
  }

}
