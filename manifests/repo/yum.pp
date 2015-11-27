class beats::repo::yum {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $beats::install_repo {
    if $beats::repo_source {
      $url = $beats::repo_source
    } else {
      $url = 'https://packages.elastic.co/beats/yum/el/$basearch/'
    }

    yumrepo { 'filebeat':
      enabled  => 1,
      baseurl  => $url,
      gpgcheck => 0,
      name     => 'filebeat',
      descr    => 'elastic.co filebeat repo',
    }
  }

}
