# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def rx_swift
    pod 'RxSwift', '~> 3.0'
end

def rx_cocoa
    pod 'RxCocoa', '~> 3.0'
end

def test_pods
    pod 'RxTest', '~> 3.0'
    pod 'RxBlocking', '~> 3.0'
    pod 'Nimble'
end


target 'BeerFinderRxSwift' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_cocoa
  rx_swift
  pod 'QueryKit'
  target 'BeerFinderRxSwiftTests' do
    inherit! :search_paths
    test_pods
  end

end

target 'CoreDataPlatform' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_swift
  pod 'QueryKit'
  target 'CoreDataPlatformTests' do
    inherit! :search_paths
    test_pods
  end

end

target 'Domain' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_swift

  target 'DomainTests' do
    inherit! :search_paths
    test_pods
  end

end

target 'NetworkPlatform' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    rx_swift
    pod 'Alamofire'
    pod 'RxAlamofire'
    pod 'ObjectMapper'
    pod 'AlamofireObjectMapper'

    target 'NetworkPlatformTests' do
        inherit! :search_paths
        test_pods
    end
    
end
