platform :ios, '13.2'
use_frameworks!

target 'TestingDemo' do
    pod 'RxSwift', '~> 5'
    pod 'RxCocoa', '~> 5'
end

# RxTest and RxBlocking make the most sense in the context of unit/integration tests
target 'TestingDemoTests' do
    pod 'RxBlocking', '~> 5'
    pod 'RxTest', '~> 5'
    pod 'Quick'
    pod 'Nimble'
    pod "SwiftyMocky"
end
