source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def shared_pods
  pod 'Promis'
  pod 'DifferenceKit'
end

target 'Tiguer' do
    shared_pods
end

target 'TiguerTests' do
  inherit! :search_paths
  shared_pods
end
