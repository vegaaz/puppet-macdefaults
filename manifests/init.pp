# Note that type can be one of:
# string, data, int, float, bool, data, array, array-add, dict, dict-add
define macdefaults($domain, $key, $value = false, $type = 'string', $action = 'write') {

  case $type {
    'bool': {
      if $value {
        $write_value = 'TRUE'
      }
      else {
        $write_value = 'FALSE'
      }
    }
    default: {
      $write_value = $value
    }
  }

  case $operatingsystem {
   'Darwin':{
    case $action {
      'write': {
        exec {"/usr/bin/defaults write ${domain} ${key} -${type} '${write_value}'":
            unless => $type ? {
              'bool' => $value ? {
                true  => "/usr/bin/defaults read ${domain} ${key} | /usr/bin/grep -qx 1",
                false => "/usr/bin/defaults read ${domain} ${key} | /usr/bin/grep -qx 0"
                },
            default  => "/usr/bin/defaults read ${domain} ${key} | /usr/bin/grep -qx ${value}"
          }
        }
      }
      'delete': {
        exec {"/usr/bin/defaults delete ${domain} ${key}":
          logoutput => false,
          onlyif    => "/usr/bin/defaults read ${domain} | /usr/bin/grep -q '${key}'"
        }
      }
    }
   }
  }


}

