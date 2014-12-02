class shifter {

  $shifterpackages = [ "npm", "python", "nodejs" ]
	
  package { $shifterpackages: ensure => "latest" }

  exec { "install_shifter":
      command => "npm install shifter@0.4.6 -g",
      path    => "/usr/bin/"
  }  	
}
