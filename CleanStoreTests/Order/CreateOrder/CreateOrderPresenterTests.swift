//
//  CreateOrderPresenterTests.swift
//  CleanStore
//
//  Created by Managam Silalahi on 12/7/16.
//  Copyright © 2016 Managam Silalahi. All rights reserved.
//

import XCTest
@testable import CleanStore

class CreateOrderPresenterTests: XCTestCase {
    
    var createOrderPresenter: CreateOrderPresenter!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupCreateOrderPresenter()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK - Test setup
    
    func setupCreateOrderPresenter() {
        createOrderPresenter = CreateOrderPresenter()
    }
    
    // MARK - Test class spy
    
    class CreateOrderPresenterOutputSpy: CreateOrderPresenterOutput {
        // MARK - Method call expectations
        var displayExpirationDateCanceled = false
        
        // MARK - Argument expectations
        var createOrder_formatExpirationDate_viewModel: CreateOrder_FormatExpirationDate_ViewModel!
        
        // MARK - Spied methods
        func displayExpirationDate(viewModel: CreateOrder_FormatExpirationDate_ViewModel) {
            displayExpirationDateCanceled = true
            self.createOrder_formatExpirationDate_viewModel = viewModel
        }
    }
    
    // MARK - Test NSDate to String
    func testPresentExpirationDateShouldConvertDateToString() {
        // Given
        let createOrderPresenterOutputSpy = CreateOrderPresenterOutputSpy()
        createOrderPresenter.output = createOrderPresenterOutputSpy
        
        let dateComponents: DateComponents = {
            var dateComponents = DateComponents()
            dateComponents.year = 2016
            dateComponents.month = 12
            dateComponents.day = 7
            return dateComponents
        }()
        
        let date = NSCalendar.current.date(from: dateComponents)
        let response = CreateOrder_FormatExpirationDate_Response(date: date!)
        
        // When
        createOrderPresenter.presentExpirationDate(response: response)
        
        // Then
        let returnedDate = createOrderPresenterOutputSpy.createOrder_formatExpirationDate_viewModel.date
        let expectedDate = "12/7/16"
        XCTAssertEqual(returnedDate, expectedDate, "Presenting an expiration date should convert date to string")
    }
    
    // MARK - Display date string
    
    func testPresentExpirationDateShouldAskViewControllerToDisplayDateString() {
        // Given
        let createOrderPresenterOutputSpy = CreateOrderPresenterOutputSpy()
        createOrderPresenter.output = createOrderPresenterOutputSpy
        
        let response = CreateOrder_FormatExpirationDate_Response(date: Date())
        
        // When
        createOrderPresenter.presentExpirationDate(response: response)
        
        // Then
        XCTAssert(createOrderPresenterOutputSpy.displayExpirationDateCanceled, "Presenting an expiration date should ask view controller to display date string")
    }
    
}
