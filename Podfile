# source 'https://github.com/native-portal/podspecs.git'

platform :ios, '14.0'
workspace 'IonicPortals'

def capacitor_pods
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Capacitor'
  pod 'CapacitorCordova'
  pod 'IonicLiveUpdates'
end

target 'IonicPortals' do
  project './IonicPortals/IonicPortals.xcodeproj'
  capacitor_pods
end
