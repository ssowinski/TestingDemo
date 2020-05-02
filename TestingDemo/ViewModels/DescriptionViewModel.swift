//
//  DescriptionViewModel.swift
//  TestingDemo
//
//  Created by Sławomir Sowiński on 01/05/2020.
//  Copyright © 2020 Sławomir Sowiński. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol DescriptionViewModelType {
    var rx_description: BehaviorRelay<String?> { get }
    var rx_isValid: Observable<Bool> { get }
    func saveButtonAction()
}

class DescriptionViewModel: DescriptionViewModelType {
    var saveCompletionHandler: (() -> Void)?
    var rx_description = BehaviorRelay<String?>(value: nil)

    var rx_isValid: Observable<Bool> {
        return rx_description
            .asObservable()
            .map({ [weak self] (text) -> Bool in
                guard let text = text else {
                    return false
                }
                return text.count >= self?._minDescriptionLength ?? 0
            })
    }

    private let _minDescriptionLength: Int

    init(minDescriptionLength: Int) {
        self._minDescriptionLength = minDescriptionLength
    }

    func saveButtonAction() {
        saveCompletionHandler?()
    }
}
