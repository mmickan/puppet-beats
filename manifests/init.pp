#
# == Class: beats
#
# Manage data shippers from Elastic's Beats platform.
#
# === Parameters
#
# [*install_repo*]
#   Default: true
#
# [*repo_source*]
#
# [*repo_key_id*]
#
# [*repo_key_source*]
#
# [*repo_release*]
#
# [*manage_services*]
#   Default: true
#
# [*debug*]
#   Boolean.  If true, this module will write the value of all variables to
#   a debug file.
#   Default: false
#
# [*debug_dir*]
#   String.  Fully qualified path to directory in which module debugging
#   file will be written.
#   Default: /var/lib/puppet/debug
#
# [*shipper_tags*]
#   Default: []
#
# [*shipper_ignore_outgoing*]
#   Default: true
#
# [*shipper_refresh_topology_freq*]
#   Default: 10
#
# [*shipper_topology_expire*]
#   Default: 15
#
# [*output_es*]
#   Default: false
#
# [*output_es_hosts*]
#   Default: ['localhost:9200']
#
# [*output_es_protocol*]
#   Default: 'http'
#
# [*output_es_username*]
#   Default: undef
#
# [*output_es_password*]
#   Default: undef
#
# [*output_es_worker*]
#   Default: 1
#
# [*output_es_path*]
#   Default: undef
#
# [*output_es_save_topology*]
#   Default: true
#
# [*output_es_index*]
#   Default: undef
#
# [*output_ls*]
#   Default: false
#
# [*output_ls_hosts*]
#   Default: ['localhost:5044']
#
# [*output_ls_worker*]
#   Default: 1
#
# [*output_ls_loadbalance*]
#   Default: false
#
# [*output_ls_index*]
#   Default: undef
#
# [*tls_certificate_authorities*]
#   Default: []
#
# [*tls_certificate*]
#   Default: undef
#
# [*tls_certificate_key*]
#   Default: undef
#
# [*tls_min_version*]
#   Default: '1.2'
#
# [*tls_max_version*]
#   Default: '1.2'
#
# [*tls_insecure*]
#   Default: false
#
# [*logging_to_syslog*]
#   Default: false
#
# [*logging_to_files*]
#   Default: true
#
# [*logging_level*]
#   Default: 'warning'
#
# [*logging_selectors*]
#   Default: []
#
# [*logging_files_path*]
#   Default: '/var/log/beats'
#
# [*logging_files_name*]
#   Default: undef
#
# === Example usage
#
#  include beats
#
class beats(
  $install_repo                  = true,
  $repo_source                   = $beats::params::repo_source,
  $repo_key_id                   = $beats::params::repo_key_id,
  $repo_key_source               = $beats::params::repo_key_source,
  $repo_release                  = 'stable',

  $manage_services               = true,

  $debug                         = false,
  $debug_dir                     = '/var/lib/puppet/debug',

  $shipper_tags                  = [],
  $shipper_ignore_outgoing       = true,
  $shipper_refresh_topology_freq = 10,
  $shipper_topology_expire       = 15,

  $output_es                     = false,
  $output_es_hosts               = ['localhost:9200'],
  $output_es_protocol            = 'http',
  $output_es_username            = undef,
  $output_es_password            = undef,
  $output_es_worker              = 1,
  $output_es_path                = undef,
  $output_es_save_topology       = true,
  $output_es_index               = undef,

  $output_ls                     = false,
  $output_ls_hosts               = ['localhost:5044'],
  $output_ls_worker              = 1,
  $output_ls_loadbalance         = false,
  $output_ls_index               = undef,

  $tls_certificate_authorities   = [],
  $tls_certificate               = undef,
  $tls_certificate_key           = undef,
  $tls_min_version               = '1.2',
  $tls_max_version               = '1.2',
  $tls_insecure                  = false,

  $logging_to_syslog             = false,
  $logging_to_files              = true,
  $logging_level                 = 'warning',
  $logging_selectors             = [],
  $logging_files_path            = '/var/log/beats',
  $logging_files_name            = undef,
) inherits beats::params {

  class { 'beats::repo': }

  if $debug {
    class { 'beats::debug': }
  }

}
