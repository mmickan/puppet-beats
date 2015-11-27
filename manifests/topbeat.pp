#
# == Class: beats::topbeat
#
# Install, configure and manage the topbeat data shipper.
#
# === Parameters
#
# [*period*]
#   Default: '10'
#
# [*procs*]
#   Default: ['.*']
#
# [*system_stats*]
#   Default: true
#
# [*proc_stats*]
#   Default: true
#
# [*filesystem_stats*]
#   Default: true
#
# [*shipper_name*]
#   Default: undef
#
# [*shipper_tags*]
#   Default: []
#
# [*output_index*]
#   Default: 'topbeat'
#
# [*tls_certificate*]
#   Default: undef
#
# [*tls_certificate_key*]
#   Default: undef
#
# === Example usage
#
#  class { 'beats::topbeat':
#    tls_certificate     => '/etc/ssl/client-cert.pem',
#    tls_certificate_key => '/etc/ssl/client-key.pem',
#  }
#
class beats::topbeat(
  $period              = '10',
  $procs               = ['.*'],
  $system_stats        = true,
  $proc_stats          = true,
  $filesystem_stats    = true,

  # overrides for selected libbeat configuration
  $shipper_name        = undef,
  $shipper_tags        = [],
  $output_index        = 'topbeat',
  $tls_certificate     = undef,
  $tls_certificate_key = undef,
) {

  include beats

  package { 'topbeat': }

  file { '/etc/topbeat/topbeat.yml':
    content => template('beats/topbeat.yml.erb', 'beats/libbeat.yml.erb'),
    require => Package['topbeat'],
  }

  if $beats::manage_services {
    service { 'topbeat':
      ensure    => 'running',
      enable    => true,
      subscribe => File['/etc/topbeat/topbeat.yml'],
    }
  }

}
