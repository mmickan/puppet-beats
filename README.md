#beats

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What beats does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [beats]](#setup)
    * [What [beats] affects](#what-[beats]-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to beats](#development)

##Overview

Deploy one or more data shippers from [Elastic](http://elastic.co/)'s
[Beats](https://www.elastic.co/products/beats) platform.

Tested with Ubuntu 14.04, but should work on other versions of Ubuntu and
other Debian derivatives.  Preliminary support for RHEL is in place but is
currently untested.

##Module Description

This module will eventually manage the three Beats data shippers (filebeat,
packetbeat and topbeat) provided by Elastic, and to a lesser extent manages
custom Beats data shippers.  In the current version only filebeat and
topbeat are supported.

##Setup

###What [beats] affects

* Installs the Beats package repository
* Installs required packages
* Writes configuration files
* Manages services for each data shipper installed

###Setup Requirements

Requires the puppetlabs/stdlib module.

##Usage


To override any of the default settings in the beats class, use Hiera:

```YAML
beats::output_es: true
beats::output_es_hosts:
  - 'elasticsearch-01.example.com:9200'
  - 'elasticsearch-02.example.com:9200'
```

In your puppet manifests instantiate filebeat and/or topbeat:

```puppet
class { 'beats::filebeat':
  tls_certificate     => '/etc/ssl/client-cert.pem',
  tls_certificate_key => '/etc/ssl/client-key.pem',
}
```

If you instantiated the filebeat class, you'll also need at least one
propector before it's useful:

```puppet
beats::filebeat::prospector { 'syslog':
  paths => [ 'var/log/syslog' ],
}
```

Full documentation of parameters is included in the init.pp manifest file.

##Reference

##Limitations

##Development

Contributions are welcome.  Open an
[issue](https://github.com/mmickan/puppet-beats/issues) or
[fork](https://github.com/mmickan/puppet-beats/fork) and open a
[pull request](https://github.com/mmickan/puppet-beats/pulls).  Passing
tests are appreciated with pull requests, but not a hard requirement.
Please ensure your commit message clearly explains the problem your patch
solves.

##Contributors

Written by Mark Mickan <mark.mickan@blackboard.com>.
