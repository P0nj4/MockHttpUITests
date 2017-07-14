#
# Be sure to run `pod lib lint MockHttpUITests.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MockHttpUITests'
  s.version          = '0.1.0'
  s.summary          = 'Mock requests you have on the app when running ui tests'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    Mock the requets on your app when you are runing the tests
                       DESC

  s.homepage         = 'https://github.com/P0nj4/MockHttpUITests'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'P0nj4' => 'german.f.pereyra@gmail.com' }
  s.source           = { :git => 'https://github.com/P0nj4/MockHttpUITests.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MockHttpUITests/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MockHttpUITests' => ['MockHttpUITests/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'OHHTTPStubs'
  s.dependency 'OHHTTPStubs/Swift'
end
