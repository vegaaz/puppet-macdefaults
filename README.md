macOS Defaults module for Puppet
==================

This module defines a `macdefaults` type which can manage preferences on macOS/OS X.

It enable Puppet to manage any setting that is changed or set using `defaults`.

This removes the need to include a large number of redundant `exec` statements to accomplish the same thing, for example:

```
exec {'Set default paper size to A4':
  command   => 'usr/bin/defaults write /Library/Preferences/com.apple.print.PrintingPrefs DefaultPaperID -string "iso-a4"',
  unless    => "/usr/bin/defaults read /Library/Preferences/com.apple.print.PrintingPrefs DefaultPaperID | grep iso-a4,
}
```

# Usage

- Add this module to your Puppet modules directory via R10k (recommended) or downloading and unzipping.
- Make use of the code in any Puppet manifest or other module:

```
macdefaults { 'set-a4':
  domain => '/Library/Preferences/com.apple.print.PrintingPrefs',
  key    => 'DefaultPaperID',
  type   => 'string',
  value  => 'iso-a4'
}
```

# Values 

Possible values for `type` are:

* `string`
* `data`
* `int`
* `float`
* `bool`
* `data`
* `array`
* `array-add`
* `dict`
* `dict-add`

# Notes

For values which can be managed via a configuration profile, it is reccomended to use the [mac_profiles_handler](https://github.com/keeleysam/puppet-mac_profiles_handler)

This module can be used for general property list key manipulation, just like `defaults`, but it is reccomended to use Gary Larizza's [property_list_key](https://github.com/glarizza/puppet-property_list_key) provider instead.

I didn't write 90% of this, but I can't for the life of me remember where I found it. I'm putting it on here for posterity.

This has been updated to be used as `macdefaults` instead of `mac-defaults` to be compatible with Puppet 4.

# To Do

* Move the working parts to Ruby to better support dictionaries and arrays, as well as to remove the dependency on `grep`.
