Pod::Spec.new do |s|
  s.name             = 'KeyboardDismisser'
  s.version          = '0.2.1'
  s.summary          = 'KeyboardDismisser is a little Swift 3.0 pod that adds a button that can dismiss keyboard'
 
  s.description      = <<-DESC
KeyboardDismisser is a little Swift 3.0 pod that adds a button that can dismiss keyboard. Button image, size and margin are all customizable.
                       DESC
 
  s.homepage         = 'https://github.com/yagiz/KeyboardDismisser'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yagiz' => 'yagizgurgul@gmail.com' }
  s.source           = { :git => 'https://github.com/yagiz/KeyboardDismisser.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '8.0'
  s.source_files = 'Classes/**/*.{swift,xib,png}'
 
end