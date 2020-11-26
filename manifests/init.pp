# Note that type can be one of:
# string, data, int, float, bool, data, array, array-add, dict, dict-add
define macdefaults($domain, $key, $value = false, $type = 'string', $action = 'write', $runas = 'root', $currenthost = false) {

  if $runas != 'root' {
    $user = $::current_user
  }

  if $currenthost {
    $writecommand = '/usr/bin/defaults -currentHost write'
    $readcommand = '/usr/bin/defaults -currentHost read'
    $deletecommand = '/usr/bin/defaults -currentHost delete'
  }
  else {
    $writecommand = '/usr/bin/defaults write'
    $readcommand = '/usr/bin/defaults read'
    $deletecommand = '/usr/bin/defaults delete'
  }

  case $value {
    true : {
      $grep = 1
    }
    false : {
      $grep = 0
    }
    default: {
      $grep = $value
    }
  }

  case $::operatingsystem {
    'Darwin':{
      case $action {
        'write': {
          exec { "${writecommand} ${domain} ${key} -${type} '${value}'":
            user   => $user,
            unless => "${readcommand} ${domain} ${key} | /usr/bin/grep -q '^${grep}$'"
          }
        }
        'delete': {
          exec { "${deletecommand} ${domain} ${key}":
            logoutput => false,
            user      => $user,
            onlyif    => "${readcommand} ${domain} | /usr/bin/grep -q '^${key}$'"
          }
        }
        default: {
          fail('Only write and delete are supported values for action.')
        }
      }
    }
    default: {
    }
  }
}
