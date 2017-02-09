# == Class: memcached
#
# Full description of class memcached here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'memcached':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class memcached	(
			$ensure='installed',
			$maxmem='64',
			$port='11211',
			$user=$memcached::params::default_user,
			$listen='127.0.0.1',
			$maxcon='1024',
			$logfile='/var/log/memcached.log',
			$error_on_oom=false,
			$threads=$::processorcount,
		) inherits params {

	validate_absolute_path($logfile)

	package { $memcached::params::package_name:
		ensure => $ensure,
	}

	file { $memcached::params::conf:
		ensure => 'present',
		owner => 'root',
		group => 'root',
		mode => '0644',
		content => template("memcached/${conftemplate}"),
		require => Package[$memcached::params::package_name],
		notify => Service[$memcached::params::servicename],
	}

	service { $memcached::params::servicename:
		ensure => 'running',
		enable => true,
	}
}
