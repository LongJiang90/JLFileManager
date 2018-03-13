#
# Be sure to run `pod lib lint JLFileManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JLFileManager'
  s.version          = '0.0.1'
  s.summary          = '下载、预览文件.'
  s.description      = <<-DESC
方便得使用manager来管理文件的 下载、查看、缓存、清理等操作。
                       DESC

  s.homepage         = 'https://github.com/983220205@qq.com/JLFileManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JiangLong' => '983220205@qq.com' }
  s.source           = { :git => 'https://github.com/983220205@qq.com/JLFileManager.git', :tag => s.version }
  s.platform     = :ios, "8.0"
  s.requires_arc = true
  s.frameworks   = 'UIKit','Foundation'

  s.source_files = 'JLFileManager/Classes/*.{h,m}'
  s.public_header_files = 'JLFileManager/Classes/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'AFNetworking', '~>  3.0.4'
end
