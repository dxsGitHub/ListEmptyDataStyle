#
#  Be sure to run `pod spec lint ListEmptyDataStyle.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "ListEmptyDataStyle"
  spec.version      = "1.0.2"
  spec.summary      = "ListEmptyDataStyle 设置UITableView、UICollectionView无数据时候的占位视图样式."
  spec.homepage     = 'https://github.com/dxsGitHub/ListEmptyDataStyle'
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "dxs" => "dxs_high@icloud.com" }
  spec.platform     = :ios, "13.0"
  spec.ios.deployment_target = "13.0"
  spec.source       = { :git => 'git://github.com/dxsGitHub/ListEmptyDataStyle.git', :tag => "1.0.2" }
  spec.resources  = "ListEmptyStyle/*.{bundle}"
  spec.source_files  = "ListEmptyStyle/*.{h,m}"

  spec.requires_arc = true

end
