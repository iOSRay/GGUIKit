#
# Be sure to run `pod lib lint GGUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GGUIKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of GGUIKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Ray/GGUIKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ray' => 'waley518@gmail.com' }
  s.source           = { :git => 'https://github.com/Ray/GGUIKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'

  s.source_files = 'GGUIKit/Classes/**/*'
  s.source                 = { :path => '/' }
  s.platform               = :ios, '10.0'
  s.requires_arc           = true
  s.prefix_header_contents = '#import "GGGlobals.h"', '#import "GGUISetting.h"','#import "YYKitMacro.h"', '#import "YYKit.h"'
  s.dependency 'YYKit'
  s.dependency 'SDWebImage'
  s.dependency 'PureLayout'
  s.dependency 'MBProgressHUD'
  s.dependency 'UICKeyChainStore'
  
  # s.resource_bundles = {
  #   'GGUIKit' => ['GGUIKit/Assets/*.png']
  # }
  
end
