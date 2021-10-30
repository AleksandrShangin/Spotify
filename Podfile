# platform :ios, '9.0'

use_frameworks!

def firebase_pods
    pod 'Firebase/Analytics'
end

def network_pods
    pod 'SDWebImage'
end

def ui_pods
    pod 'ColorCompatibility' 
end

def target_pods
    firebase_pods  
    network_pods
    ui_pods
end

target 'Spotify' do
    target_pods
end
