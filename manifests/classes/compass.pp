class compass {

    # We need ruby gem installer
    package { ['rubygems', 'ruby-devel'] :
        ensure => installed
    }

    # Install compass with gem
    package { ['compass', 'rake', 'json'] :
        ensure => latest,
        provider => 'gem',
    	require => [Package['rubygems'], Package['ruby-devel']]
    }
	
    # Install sass-css-importer. Need to use exec, because need to have the --pre command.
    exec { 'sass-css-importer-install':
    	command => '/usr/bin/gem install --pre sass-css-importer',
    	unless => '/usr/bin/gem list -i sass-css-importer',
    	require => Package['rubygems']
    }

}
