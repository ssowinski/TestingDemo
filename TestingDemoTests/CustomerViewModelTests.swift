//
//  CustomerViewModelTests.swift
//  TestingDemoTests
//
//  Created by Sławomir Sowiński on 23/02/2020.
//  Copyright © 2020 Sławomir Sowiński. All rights reserved.
//

import Foundation
import Nimble
import Quick
import RxSwift
import RxTest
import SwiftyMocky

@testable import TestingDemo

class CustomerViewModelTests: QuickSpec {
    override func spec() {
        var sut: CustomerViewModel!
        var providerMock: CustomerProviderTypeMock!
        var testScheduler: TestScheduler!
        var disposeBag: DisposeBag!

        let testCustomer: Customer = Customer(id: "TEST-ID", name: "TEST-NAME")
        let testCustomerId: String = "TEST-ID"
        let testError = TestError()

        func createSut() {
            sut = CustomerViewModel(provider: providerMock, customerId: testCustomerId)
        }

        func createRxObject() {
            disposeBag = DisposeBag()

            // initializer takes in an initialClock argument that defines the “starting time” for your stream
            testScheduler = TestScheduler(initialClock: 0)
        }

        func createProvider() {
            providerMock = CustomerProviderTypeMock()
        }

        // mocking function that calls handler
        func setupProviderMockForSuccess() {
            providerMock.perform(.getCustomer(with: .any,
                                              successHandler: .any,
                                              errorHandler: .any,
                                              perform: { (_, successHandler, _) in
                                                successHandler(testCustomer)
            }))
        }

        func setupProviderMockForError() {
            providerMock.perform(.getCustomer(with: .any,
                                              successHandler: .any,
                                              errorHandler: .any,
                                              perform: { (_, _, errorHandler) in
                                                errorHandler(testError)
            }))
        }

        // TODO: mocking function thet return value

        func clearAll() {
            sut = nil
            providerMock = nil
            testScheduler = nil
            disposeBag = nil
        }

        describe("CustomerViewModelTypeTests") {
            beforeEach {
                createRxObject()
                createProvider()
                createSut()
            }

            afterEach {
                clearAll()
            }

            describe("init") {
                it("rx_state should emit one value") {
                    let testObserver = testScheduler.createObserver(FetchingState.self)

                    sut.rx_state
                        .subscribe(testObserver)
                        .disposed(by: disposeBag)

                    expect(testObserver.events.count).to(equal(1))
                    expect(testObserver.events.last!.value.element).to(equal(FetchingState.none))
                }

                it("getCustomer() should return nil") {
                    expect(sut.getCustomer()).to(beNil())
                }

                it("getError() should return nil") {
                    expect(sut.getError()).to(beNil())
                }

                describe("viewWillAppear") {
                    context("fetch with error") {
                        beforeEach {
                            setupProviderMockForError()
                        }

                        it("should call provider methode") {
                            sut.viewWillAppear()
                            providerMock.verify(.getCustomer(with: .value(testCustomerId),
                                                             successHandler: .any,
                                                             errorHandler: .any),
                                                count: 1)
                        }

                        it("rx_state should emit three value, last error") {
                            let testObserver = testScheduler.createObserver(FetchingState.self)

                            sut.rx_state
                                .subscribe(testObserver)
                                .disposed(by: disposeBag)

                            testScheduler.scheduleAt(10) {
                                sut.viewWillAppear()
                            }

                            testScheduler.start()

                            let expectedEvents = [
                                Recorded.next(0, FetchingState.none),
                                Recorded.next(10, FetchingState.inProgress),
                                Recorded.next(10, FetchingState.error),
                            ]

                            XCTAssertEqual(testObserver.events, expectedEvents)
                        }

                        it("getCustomer() should return nil") {
                            sut.viewWillAppear()
                            expect(sut.getCustomer()).to(beNil())
                        }

                        it("getError() should return testError") {
                            sut.viewWillAppear()
                            expect(sut.getError()).to(matchError(testError))
                        }
                    }
                }

                context("fetch with success") {
                    beforeEach {
                        setupProviderMockForSuccess()
                    }

                    it("should call provider methode") {
                        sut.viewWillAppear()
                        providerMock.verify(.getCustomer(with: .value(testCustomerId),
                                                         successHandler: .any,
                                                         errorHandler: .any),
                                            count: 1)
                    }

                    it("rx_state should emit three value, last results") {
                        let testObserver = testScheduler.createObserver(FetchingState.self)

                        sut.rx_state
                            .subscribe(testObserver)
                            .disposed(by: disposeBag)

                        testScheduler.scheduleAt(10) {
                            sut.viewWillAppear()
                        }

                        testScheduler.start()

                        let expectedEvents = [
                            Recorded.next(0, FetchingState.none),
                            Recorded.next(10, FetchingState.inProgress),
                            Recorded.next(10, FetchingState.results),
                        ]

                        XCTAssertEqual(testObserver.events, expectedEvents)
                    }

                    it("getCustomer() should return testCustomer") {
                        sut.viewWillAppear()
                        expect(sut.getCustomer()).to(equal(testCustomer))
                    }

                    it("getError() should return nil") {
                        sut.viewWillAppear()
                        expect(sut.getError()).to(beNil())
                    }
                }
            }
        }
    }
}
