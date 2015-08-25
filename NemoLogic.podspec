Pod::Spec.new do |s|
  s.name         = "NemoLogic"
  s.version      = "1.0.0"
  s.summary      = "Universal service provider, main goal is to speed up the architectural development of the projects."
  s.homepage     = 'http://www.neofonie-mobile.de/'
  s.social_media_url = 'https://twitter.com/neofoniemobile'
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.authors      = { 'Neofonie Mobile GmbH' => 'contact@neofonie.de' }
  s.source       = { :git => 'https://github.com/neofoniemobile/NemoLogic.git',
                     :tag => s.version.to_s }

  s.ios.platform     = :ios
  s.ios.deployment_target = '7.1'

  s.osx.platform     = :osx
  s.osx.deployment_target = '10.8'

  s.source_files = 'Nemo\ Logic/**/*.{h,m}'
end
