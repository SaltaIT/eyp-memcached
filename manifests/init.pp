class memcached (
                  $ensure          = 'installed',
                  $maxmem          = '64',
                  $port            = '11211',
                  $user            = $memcached::params::default_user,
                  $listen          = '127.0.0.1',
                  $maxcon          = '1024',
                  $logfile         = '/var/log/memcached.log',
                  $error_on_oom    = false,
                  $threads         = $::processorcount,
									$verbose_level   = '0',
									$memory_lockdown = false,
                ) inherits params {

  validate_absolute_path($logfile)

  package { $memcached::params::package_name:
    ensure => $ensure,
  }

  file { $memcached::params::conf:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("memcached/${conftemplate}"),
    require => Package[$memcached::params::package_name],
    notify  => Service[$memcached::params::servicename],
  }

  service { $memcached::params::servicename:
    ensure => 'running',
    enable => true,
  }
}
