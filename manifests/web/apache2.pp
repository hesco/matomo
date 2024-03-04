
# Usage: include matomo::web::apache2

class matomo::web::apache2 {

  $site_name = lookup ( 'matomo::web::apache2::site_name', String, 'first', 'matomo.host' )
  $server_admin = lookup ( 'matomo::web::apache2::server_admin', String, 'first', 'hesco@yourmessagedelivered.com' )
  $deploy_certbot = lookup ( 'matomo::web::deploy_certbot', Boolean, 'first', false )
  $php_version = lookup ( 'matomo::web::apache2::php_version', String, 'first', '7.0')

  package { [
    "php${php_version}",
    'php-cli',
    'libapache2-mod-php',
    'php-common',
    'php-curl',
    'php-gd',
    'php-mbstring',
    'php-mysql',
    'php-xml',
    'php-intl',
    'php-zip' ]:
    ensure => latest,
  }

  file { "/etc/apache2/sites-available/010-${site_name}.conf":
    content => template('matomo/010-matomo.conf'),
    mode    => '0755',
    require => Package['libapache2-mod-php'],
  }->

  exec { "a2ensite 010-${site_name}":
    command => "/usr/sbin/a2ensite 010-${site_name}.conf",
  }
  # notify  => Service['apache2'],

  exec { "a2dissite 000-default":
    command => "/usr/sbin/a2dissite 000-default.conf",
  }

  service { 'apache2':
    ensure => running,
  }

  if $deploy_certbot {

    package { 'python3-certbot-apache':
      ensure => latest,
    }

    exec { 'generate_ssl_certificate_with_certbot':
      command => "/usr/bin/certbot --apache",
    }

  }

}

