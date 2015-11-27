#
# == Class: beats::debug
#
# Write all variables to a file to allow them to be inspected for debugging
# this module.
#
# === Example usage
#
# This class is autoloaded if $beats::debug is set to true.
#
class beats::debug {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  ensure_resource('file', $beats::debug_dir, {
    ensure => 'directory',
  })

  file { "${beats::debug_dir}/beats":
    ensure  => 'present',
    content => template('beats/debug_variables.erb'),
    mode    => '0400',
    owner   => 'root',
    group   => 'root',
  }

}
