#
#  Be sure to run `pod spec lint ZenMenu.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ZenMenu"
  s.version      = "1.0.0"
  s.summary      = "A customizable menu that displays menu items in various circle patterns around the menu button."

  s.description  = "A customizable menu that displays menu items in various circle patterns the menu button. Choose to display menu items in a full, half, or quarter circle shape around the menu button. Create menu items using a simple string, an image, or a custom UIView you built."

  s.homepage     = "http://zenbanana.com"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author             = { "Tanner Juby" => "support@zenbanana.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/zenbanana/zenmenu.git", :tag => "#{s.version}" }
  s.source_files  = "ZenMenu", "ZenMenu/**/*.{h,m,swift}"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

end
