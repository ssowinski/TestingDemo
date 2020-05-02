//
//  DescriptionViewModelTests.swift
//  TestingDemoTests
//
//  Created by Sławomir Sowiński on 01/05/2020.
//  Copyright © 2020 Sławomir Sowiński. All rights reserved.
//

import Foundation
import Nimble
import Quick
import RxCocoa
import RxSwift
import RxTest
import SwiftyMocky

@testable import TestingDemo

class DescriptionViewModelTests: QuickSpec {
    override func spec() {
        var sut: DescriptionViewModel!

        var testScheduler: TestScheduler!
        var disposeBag: DisposeBag!

        let testMinDescriptionLength: Int = 10

        func createSut() {
            sut = DescriptionViewModel(minDescriptionLength: testMinDescriptionLength)
        }

        func createRxObject() {
            disposeBag = DisposeBag()

            // initializer takes in an initialClock argument that defines the “starting time” for your stream
            testScheduler = TestScheduler(initialClock: 0)
        }

        func clearAll() {
            sut = nil
            testScheduler = nil
            disposeBag = nil
        }

        describe("DescriptionViewModelTests") {
            beforeEach {
                createRxObject()
                createSut()
            }

            afterEach {
                clearAll()
            }

            describe("init") {
                it("rx_isValid should emit one value") {
                    let testObserver = testScheduler.createObserver(Bool.self)

                    sut.rx_isValid
                        .subscribe(testObserver)
                        .disposed(by: disposeBag)

                    expect(testObserver.events.count).to(equal(1))
                    expect(testObserver.events.last!.value.element).to(beFalse())
                }
            }

            describe("changing rx_description") {
                it("rx_isValid should emit proper events") {
                    let isValidObserver = testScheduler.createObserver(Bool.self)

                    sut.rx_isValid
                        .subscribe(isValidObserver)
                        .disposed(by: disposeBag)

                    let descriptionInputCO = testScheduler.createColdObservable([.next(10, "123"),
                                                                                 .next(15, "1234"),
                                                                                 .next(20, "123456789012"),
                                                                                 .next(25, nil),
                                                                                 .next(30, "1234567890"),
                                                                                 .next(35, "12")])
                    descriptionInputCO.bind(to: sut.rx_description)
                        .disposed(by: disposeBag)
                    testScheduler.start()

                    let expectedIsValidOutput: [Recorded<Event<Bool>>] = [
                        .next(0, false),
                        .next(10, false),
                        .next(15, false),
                        .next(20, true),
                        .next(25, false),
                        .next(30, true),
                        .next(35, false)
                    ]

                    XCTAssertEqual(isValidObserver.events,
                                   expectedIsValidOutput)
                }
            }
        }
    }
}
