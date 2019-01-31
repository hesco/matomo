# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include matomo::web
class matomo::web::web (

  $site_name                    = $matomo::params::site_name,
  $listen_port                  = $matomo::params::listen_port,
  $www_root                     = $matomo::params::www_root,
  $use_default_location         = $matomo::params::use_default_location,
  $access_log                   = $matomo::params::access_log,
  $error_log                    = $matomo::params::error_log,
  $mode                         = $matomo::params::mode,
  $ssl                          = $matomo::params::ssl,
  $ssl_key                      = $matomo::params::ssl_key,
  $ssl_cert                     = $matomo::params::ssl_cert,
  $ensure                       = $matomo::params::ensure,
  $location                     = $matomo::params::location,
  $server                       = $matomo::params::server,
  $fastcgi                      = $matomo::params::fastcgi,
  $include                      = $matomo::params::include,
  $fastcgi_param                = $matomo::params::fastcgi_param,

) {

class { '::nginx': }

  nginx::resource::server { $site_name:
      listen_port          => $listen_port,
      www_root             => $www_root,
      use_default_location => $use_default_location,
      access_log           => $access_log,
      error_log            => $error_log,
      mode                 => $mode,
      ssl                  => $ssl,
      ssl_key              => $ssl_key,
      ssl_cert             => $ssl_cert,
  }
  nginx::resource::location { $site_name:
      ensure        => $ensure,
      ssl           => $ssl,
      location      => $location,
      server        => $server,
      fastcgi       => $fastcgi,
      include       => $include,
      fastcgi_param => $fastcgi_param,
  }

#php class

class { '::php':
      ensure       => latest,
      manage_repos => true,
      fpm          => true,
      dev          => true,
      composer     => true,
      pear         => true,
      phpunit      => false,
      extensions   => {
        curl      => { },
        gd        => { },
        mysql     => { },
        xml       => { },
        mbstring  => { },
        json      => { },
        libxml    => { },
        dom       => { },
        simplexml => { },
        },
    settings       => {
      'PHP/max_input_time'                => '300',
      'PHP/memory_limit'                  => '64M',
      'PHP/post_max_size'                 => '32M',
      'PHP/upload_max_filesize'           => '32M',
      'PHP/always_populate_raw_post_data' => '-1',
      'PHP/session.auto_start'            => '0',
      'PHP/max_execution_time'            => '0',
  },
  }

}
