# Note that type can be one of:
# string, data, int, float, bool, data, array, array-add, dict, dict-add
define macdefaults($domain, $key, $value = false, $type = 'string', $action = 'write', $runas = 'root') {

  if $runas != 'root' {
    $user = $::current_user
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
          exec { "/usr/bin/defaults write ${domain} ${key} -${type} '${value}'":
            user   => $user,
            unless => "/usr/bin/defaults read ${domain} ${key} | /usr/bin/grep -qx '${grep}'"
          }
        }
        'delete': {
          exec { "/usr/bin/defaults delete ${domain} ${key}":
            logoutput => false,
            onlyif    => "/usr/bin/defaults read ${domain} | /usr/bin/grep -q '${key}'"
          }
        }
        default: {
          fail('Only write and delete are supported values for action.')
        }
      }
    }
  }
}
