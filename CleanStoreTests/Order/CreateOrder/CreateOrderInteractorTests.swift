//
//  CreateOrderInteractorTests.swift
//  CleanStore
//
//  Created by Managam Silalahi on 12/7/16.
//  Copyright © 2016 Managam Silalahi. All rights reserved.
//

import XCTest
@testable import CleanStore

class CreateOrderInteractorTests: XCTestCase {
    
    var createOrderInteractor: CreateOrderInteractor!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupCreateOrderInteractor()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK - Test setup
    func setupCreateOrderInteractor() {
        createOrderInteractor = CreateOrderInteractor()
    }
    
    // MARK - Test doubles
    class CreateOrderInteractorOutputSpy: CreateOrderInteractorOutput {
        var presentExpirationDataCalled = false
        
        func presentExpirationDate(response: CreateOrder_FormatExpirationDate_Response) {
            presentExpirationDataCalled = true
        }
    }
    
    // MARK - Test format expiration date
    func testFormatExpirationDateShouldAskPresenterToFormatExpirationDate() {
        // Given
        let createOrderInteractorOutputSpy = CreateOrderInteractorOutputSpy()
        createOrderInteractor.output = createOrderInteractorOutputSpy
        let request = CreateOrder_FormatExpirationDate_Request(date: NSDate())
        
        // When
        createOrderInteractor.formatExpirationDate(request: request)
        
        // Then
        XCTAssert(createOrderInteractorOutputSpy.presentExpirationDataCalled, "Formatting an expiration date should ask presenter to do it")
    }
    
    // MARK - Test shipping methods
    func testShippingMethodsShouldReturnAllAvailableShippingMethods() {
        // Given
        let allAvailableShippingMethods = ["Standard Shipping",
                                           "Two-day Shipping",
                                           "One-day Shipping"]
        
        // When
        let returnedShippingMethods = createOrderInteractor.shippingMethods
        
        // Then
        XCTAssertEqual(allAvailableShippingMethods, returnedShippingMethods, "Shipping Methods should list all available shipping methods")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
