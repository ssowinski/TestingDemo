platform :ios, '13.2'
use_frameworks!

target 'TestingDemo' do
    pod 'RxSwift'
    pod 'RxCocoa'

    # RxTest and RxBlocking make the most sense in the context of unit/integration tests
    target 'TestingDemoTests' do
        pod 'RxBlocking'
        pod 'RxTest'
        pod 'Quick'
        pod 'Nimble'
        pod "SwiftyMocky"
    end
end
