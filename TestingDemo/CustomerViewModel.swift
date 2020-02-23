//
//  CustomerViewModel.swift
//  TestingDemo
//
//  Created by Sławomir Sowiński on 23/02/2020.
//  Copyright © 2020 Sławomir Sowiński. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

enum FetchingState {
    case none
    case inProgress
    case results
    case error
}

protocol CustomerViewModelType {
    var rx_state: Observable<FetchingState> { get }
    func getCustomer() -> Customer?
    func getError() -> Error?
    func viewWillAppear()
}

class CustomerViewModel: CustomerViewModelType {
    var rx_state: Observable<FetchingState> {
        return _state.asObservable().distinctUntilChanged()
    }

    private let _provider: CustomerProviderType
    private let _customerId: String

    private let _state: BehaviorRelay<FetchingState> = BehaviorRelay(value: .none)

    private var _customer: Customer?
    private var _error: Error?

    init(provider: CustomerProviderType, customerId: String) {
        self._provider = provider
        self._customerId = customerId
    }

    func getCustomer() -> Customer? {
        return _customer
    }

    func getError() -> Error? {
        return _error
    }

    func viewWillAppear() {
        fetchCustomer()
    }

    private func fetchCustomer() {
        _state.accept(.inProgress)

        _provider.getCustomer(with: _customerId, successHandler: { [weak self] (customer) in
            self?._customer = customer
            self?._state.accept(.results)
        }, errorHandler: { (error) in
            self._error = error
            self._state.accept(.error)
        })
    }
}
