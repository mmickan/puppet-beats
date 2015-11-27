#
# == Define: beats::filebeat::prospector
#
# Deploy configuration for a single filebeat prospector.
#
# === Parameters
#
# [*namevar*]
#   If there is a parameter that defaults to the value of the title
#   string when not explicitly set, you must always say so.  This parameter
#   can be referred to as a "namevar" since its functionally equivalent to
#   the namevar of a core resource type
#
# [*parameter_name*]
#   Description of this parameter.
#
# === Example usage
#
#  beats::filebeat::prospector { 'namevar':
#    parameter_name => 'parameter_name value',
#  }
#
define beats::filebeat::prospector(
  $paths,
  $encoding              = undef,
  $input_type            = undef,
  $fields                = undef,
  $fields_under_root     = undef,
  $ignore_older          = undef,
  $document_type         = undef,
  $scan_frequency        = undef,
  $harvester_buffer_size = undef,
  $tail_files            = undef,
  $backoff               = undef,
  $max_backoff           = undef,
  $backoff_factor        = undef,
  $partial_line_waiting  = undef,
  $force_close_files     = undef,
) {

  include beats::filebeat

  $_encoding              = pick($encoding, $beats::filebeat::encoding)
  $_input_type            = pick($input_type, $beats::filebeat::input_type)
  $_fields                = pick($fields, $beats::filebeat::fields)
  $_fields_under_root     = pick($fields_under_root, $beats::filebeat::fields_under_root)
  $_ignore_older          = pick($ignore_older, $beats::filebeat::ignore_older)
  $_document_type         = pick($document_type, $beats::filebeat::document_type)
  $_scan_frequency        = pick($scan_frequency, $beats::filebeat::scan_frequency)
  $_harvester_buffer_size = pick($harvester_buffer_size, $beats::filebeat::harvester_buffer_size)
  $_tail_files            = pick($tail_files, $beats::filebeat::tail_files)
  $_backoff               = pick($backoff, $beats::filebeat::backoff)
  $_max_backoff           = pick($max_backoff, $beats::filebeat::max_backoff)
  $_backoff_factor        = pick($backoff_factor, $beats::filebeat::backoff_factor)
  $_partial_line_waiting  = pick($partial_line_waiting, $beats::filebeat::partial_line_waiting)
  $_force_close_files     = pick($force_close_files, $beats::filebeat::force_close_files)

  file { "/etc/filebeat/conf.d/${name}.yml":
    content => template('beats/prospector.yml.erb'),
  }

}
