class memcached::params {

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^7.*$/:
        {
          $package_name='memcached'
          $default_user='memcached'
          $conftemplate='rh/memcached.erb'
          $conf='/etc/sysconfig/memcached'
          $servicename='memcached'
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^1[46].*$/:
            {
              $package_name='memcached'
              $default_user='memcache'
              $conftemplate='debian/memcached.erb'
              $conf='/etc/memcached.conf'
              $servicename='memcached'
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
