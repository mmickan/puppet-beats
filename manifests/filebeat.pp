#
# == Class: beats::filebeat
#
# Install, configure and manage the filebeat data shipper.
#
# === Parameters
#
# [*spool_size*]
#   Default: 1024
#
# [*idle_timeout*]
#   Default: '5s'
#
# [*registry_file*]
#   Default: '/var/lib/filebeat/registry'
#
# [*config_dir*]
#   Default: '/etc/filebeat/conf.d'
#
# [*encoding*]
#   Default: 'plain'
#
# [*input_type*]
#   Default: 'log'
#
# [*fields*]
#   Default: {}
#
# [*fields_under_root*]
#   Default: false
#
# [*ignore_older*]
#   Default: '24h'
#
# [*document_type*]
#   Default: 'log'
#
# [*scan_frequency*]
#   Default: '10s'
#
# [*harvester_buffer_size*]
#   Default: '16384'
#
# [*tail_files*]
#   Default: false
#
# [*backoff*]
#   Default: '1s'
#
# [*max_backoff*]
#   Default: '10s'
#
# [*backoff_factor*]
#   Default: '2'
#
# [*partial_line_waiting*]
#   Default: '5s'
#
# [*force_close_files*]
#   Default: false
#
# [*shipper_name*]
#   Default: undef
#
# [*shipper_tags*]
#   Default: []
#
# [*output_index*]
#   Default: 'filebeat'
#
# [*tls_certificate*]
#   Default: undef
#
# [*tls_certificate_key*]
#   Default: undef
#
# === Example usage
#
#  class { 'beats::filebeat':
#    tls_certificate     => '/etc/ssl/client-cert.pem',
#    tls_certificate_key => '/etc/ssl/client-key.pem',
#  }
#
class beats::filebeat(
  # general filebeat configuration options
  $spool_size            = '1024',
  $idle_timeout          = '5s',
  $registry_file         = '/var/lib/filebeat/registry',
  $config_dir            = '/etc/filebeat/conf.d',

  # defaults for prospectors
  $encoding              = 'plain',
  $input_type            = 'log',
  $fields                = {},
  $fields_under_root     = false,
  $ignore_older          = '24h',
  $document_type         = 'log',
  $scan_frequency        = '10s',
  $harvester_buffer_size = '16384',
  $tail_files            = false,
  $backoff               = '1s',
  $max_backoff           = '10s',
  $backoff_factor        = '2',
  $partial_line_waiting  = '5s',
  $force_close_files     = false,

  # overrides for selected libbeat configuration
  $shipper_name          = undef,
  $shipper_tags          = [],
  $output_index          = 'filebeat',
  $tls_certificate       = undef,
  $tls_certificate_key   = undef,
) {

  include beats

  package { 'filebeat': }

  file { '/etc/filebeat/filebeat.yml':
    content => template('beats/filebeat.yml.erb', 'beats/libbeat.yml.erb'),
    require => Package['filebeat'],
  }

  if $beats::manage_services {
    service { 'filebeat':
      ensure    => 'running',
      enable    => true,
      subscribe => File['/etc/filebeat/filebeat.yml']
    }

    Beats::Filebeat::Prospector<||> ~> Service['filebeat']
  }

}
