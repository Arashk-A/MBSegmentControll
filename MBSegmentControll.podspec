#
# Be sure to run `pod lib lint MBSegmentControll.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MBSegmentControll'
  s.version          = '0.1.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }
  #s.swift_version    = '4.2'
  s.summary          = 'A fully customizable SegmentControll with right to left support.'

  s.description      = <<-DESC
                        Customizable SegmentControll for ios. This library support image and text for segment title placeholder. Also if you want to have support for Right_to_Left languages this library have fully supports that future as well.
                       DESC

  s.homepage         = 'https://github.com/Arashk-A/MBSegmentControll'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'm.birang' => 'm.birang@gmail.com' }
  s.source           = { :git => 'https://github.com/Arashk-A/MBSegmentControll.git', :tag => s.version }
  s.social_media_url = 'https://twitter.com/mbirang'

  s.ios.deployment_target = '9.0'
  s.platform         = :ios
  
  s.source_files     = 'MBSegmentControll/Classes/**/*'
  s.requires_arc     = true
  s.framework        = 'UIKit'

end
