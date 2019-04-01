source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def shared_pods
  pod 'Promis'
end

target 'Tiguer' do
    shared_pods
end

target 'TiguerTests' do
  inherit! :search_paths
  shared_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'YES'
    end
  end
end
