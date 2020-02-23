// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 3.5.0

import SwiftyMocky
#if !MockyCustom
import XCTest
#endif
import Foundation
@testable import TestingDemo


// MARK: - CustomerProviderType
open class CustomerProviderTypeMock: CustomerProviderType, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getCustomer(with id: String,                     successHandler: SuccessActionType,                     errorHandler: ErrorActionType) {
        addInvocation(.m_getCustomer__with_idsuccessHandler_successHandlererrorHandler_errorHandler(Parameter<String>.value(`id`), Parameter<SuccessActionType>.any, Parameter<ErrorActionType>.any))
		let perform = methodPerformValue(.m_getCustomer__with_idsuccessHandler_successHandlererrorHandler_errorHandler(Parameter<String>.value(`id`), Parameter<SuccessActionType>.any, Parameter<ErrorActionType>.any)) as? (String, SuccessActionType, ErrorActionType) -> Void
		perform?(`id`, `successHandler`, `errorHandler`)
    }


    fileprivate enum MethodType {
        case m_getCustomer__with_idsuccessHandler_successHandlererrorHandler_errorHandler(Parameter<String>, Parameter<SuccessActionType>, Parameter<ErrorActionType>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_getCustomer__with_idsuccessHandler_successHandlererrorHandler_errorHandler(let lhsId, let lhsSuccesshandler, let lhsErrorhandler), .m_getCustomer__with_idsuccessHandler_successHandlererrorHandler_errorHandler(let rhsId, let rhsSuccesshandler, let rhsErrorhandler)):
                guard Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsSuccesshandler, rhs: rhsSuccesshandler, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsErrorhandler, rhs: rhsErrorhandler, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getCustomer__with_idsuccessHandler_successHandlererrorHandler_errorHandler(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getCustomer(with id: Parameter<String>, successHandler: Parameter<SuccessActionType>, errorHandler: Parameter<ErrorActionType>) -> Verify { return Verify(method: .m_getCustomer__with_idsuccessHandler_successHandlererrorHandler_errorHandler(`id`, `successHandler`, `errorHandler`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getCustomer(with id: Parameter<String>, successHandler: Parameter<SuccessActionType>, errorHandler: Parameter<ErrorActionType>, perform: @escaping (String, SuccessActionType, ErrorActionType) -> Void) -> Perform {
            return Perform(method: .m_getCustomer__with_idsuccessHandler_successHandlererrorHandler_errorHandler(`id`, `successHandler`, `errorHandler`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

