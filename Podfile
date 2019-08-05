platform :ios, '12.2'

target 'AirsideLab' do
  use_frameworks!

	pod 'Alamofire'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5'
    end
  end
end

target 'AirsideLabTests' do
  inherit! :search_paths
  # Pods for testing
end


