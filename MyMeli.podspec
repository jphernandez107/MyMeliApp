#
# Be sure to run `pod lib lint MyMeli.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MyMeli'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MyMeli.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!


  s.homepage         = 'https://github.com/juanpahernan/MyMeli'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'juanpahernan' => 'juanpablo.hernandez@mercadolibre.com' }
  s.source           = { :git => 'https://github.com/juanpahernan/MyMeli.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.static_framework = true

  s.source_files  = "LibraryComponents/Classes/**/*.{swift}"
  s.resources = "LibraryComponents/Classes/**/*.xib",
                "LibraryComponents/Assets/**/*.plist",
                "LibraryComponents/Assets/**/*.ttf",
                "LibraryComponents/Assets/**/*.bundle"
  s.ios.resource_bundles = { 'MLItemsResources' => ['LibraryComponents/Assets/**/*.xcassets']}
  
end
