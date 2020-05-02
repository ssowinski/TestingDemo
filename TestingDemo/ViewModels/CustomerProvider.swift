//
//  CustomerProvider.swift
//  TestingDemo
//
//  Created by Sławomir Sowiński on 23/02/2020.
//  Copyright © 2020 Sławomir Sowiński. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol CustomerProviderType {
    typealias SuccessActionType = (Customer) -> Void
    typealias ErrorActionType = (Error) -> Void

    func getCustomer(with id: String,
                     successHandler: SuccessActionType,
                     errorHandler: ErrorActionType)
}
