#
# Be sure to run `pod lib lint BAError.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BAError'
  s.version          = '0.2.1'
  s.summary          = 'Helper category for NSError.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Helper category for NSError, mark details of NSError more effective.
                       DESC

  s.homepage         = 'https://github.com/benarvin/BAError'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'benarvin' => 'benarvin93@outlook.com' }
  s.source           = { :git => 'https://github.com/benarvin/BAError.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.6'

  s.source_files = 'BAError/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BAError' => ['BAError/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
