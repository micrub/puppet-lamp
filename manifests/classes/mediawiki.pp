class mediawiki {
		
	# Create link to mediawiki source by copying mediawiki.conf to appropiate place.
    file { "/etc/httpd/conf.d/mediawiki.conf":
        owner   => root,
        group   => root,
        mode    => 660,
        source  => "/vagrant/files/etc/httpd/conf.d/mediawiki.conf",
        require => [ Package[httpd] ]
    }
    
}
