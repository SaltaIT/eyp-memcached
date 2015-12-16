define memcached::instance  (
                              $instancename=$name,
                              $maxmem='64',
                        			$port='11211',
                        			$user=$memcached::params::default_user,
                        			$listen='127.0.0.1',
                        			$maxcon='1024',
                        			$logfile='/var/log/memcached.log',
                        			$error_on_oom=false,
                        			$threads=$::processorcount,
                            ){
  #
  fail("TODO!")
}
