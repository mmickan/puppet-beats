class beats::repo::apt {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $beats::install_repo {
    if defined(apt::source) {

      $ensure = $beats::install_repo ? {
        true    => 'present',
        default => 'absent',
      }

      if $beats::repo_source {
        $url = $beats::repo_source
      } else {
        $url = 'https://packages.elastic.co/beats/apt'
      }

      apt::source { 'beats':
        ensure     => $ensure,
        location   => $url,
        release    => 'stable',
        repos      => 'main',
        include    => {
          deb => true,
          src => false,
        },
        key        => {
          id     => $beats::repo_key_id,
          source => $beats::repo_key_source,
        },
      }

    } else {
      fail('This class requires puppet-apt module')
    }
  }

}
