#
# == Class: beats::params
#
# OS-specific configuration settings for Beats.
#
# === Example usage
#
# This class should not be instantiated directly.
#
class beats::params {

  case $::osfamily {
    'Debian': {
      $repo_source     = 'https://packages.elastic.co/beats/apt'
      $repo_key_id     = '46095ACC8548582C1A2699A9D27D666CD88E42B4'
      $repo_key_source = 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch'
    }

    'RedHat': {
      $repo_source     = 'https://packages.elastic.co/beats/yum/el/$basearch/'
      $repo_key_id     = undef
      $repo_key_source = undef
    }

    default: { fail("${::operatingsystem} is not supported") }
  }

}
