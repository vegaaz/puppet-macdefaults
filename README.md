macOS Defaults module for Puppet
==================

This module manages defaults on macOS (defaults write ...)

This module will enable Puppet to manage any setting that is changed or set using defaults write. 

This is a more 'Puppety' way of that removes the need to use something like: 

     exec {"Set Defaults":
        command   => "/usr/bin/defaults write /Library/Preferences/NAME KEY -TYPE VALUE,
        unless    => "/usr/bin/defaults read /Library/Preferences/NAME KEY | grep VALUE,
      }
# Usage

- Place unzipped macdefaults folder into your Puppet environment of choice (/environments/testing/modules/macdefaults)
- Make use of the code in any .pp file within the module of your choice (environments/testing/modules/printing/preferences.pp for example):

	  class printer {	
	    macdefaults { "set-a4":
              domain   => '/Library/Preferences/com.apple.print.PrintingPrefs',
              key      => 'DefaultPaperID',
              type     => 'string',
              value    => "iso-a4",
	     }
	 }

# Values 

Possible valuse for ``type`` are:

* string
* data
* int
* float
* bool
* data
* array
* array-add
* dict
* dict-add

# Note

I didn't write 90% of this, but I can't for the life of me remember where I found it. I'm putting it on here for posterity.


This has been updated to be used as `macdefaults` instead of `mac-defaults` to be compatible with Puppet 4.
