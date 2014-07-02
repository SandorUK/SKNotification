Pod::Spec.new do |s|
  s.name         = "SKNotification"
  s.version      = "1.0"
  s.summary      = "Nice and easy unobtrusive notifications."

  s.description  = <<-DESC
                   Nice and easy customisable unobtrusive in-app notifications.

					Customisation:
                   * Autoresizing for large text
                   * Colours and icons for various statuses (e.g. Alert, Failure)
                   * Notification without icon
                   * Custom fonts supported
                   * Translucent notifications supported
                   * Multiple notifications on one screen
                   DESC

    s.homepage     = "https://github.com/SandorUK/SKNotification"
	s.license      = {:type => 'MIT', :file => 'LICENSE'}
  	s.author             = { "Sandor Kolotenko" => "sandor@isandor.com" }
  	s.social_media_url   = "http://twitter.com/iSandor"
  	
  	s.platform     = :ios
	s.source       = { :git => "https://github.com/SandorUK/SKNotification.git", :tag => "1.0" }
	
  	s.source_files  = "Classes", "Classes/**/*.{h,m}"
  	
  	s.requires_arc = true
end
