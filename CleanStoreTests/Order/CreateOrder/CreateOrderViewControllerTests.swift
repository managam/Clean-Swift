//
//  CreateOrderViewControllerTests.swift
//  CleanStore
//
//  Created by Managam Silalahi on 12/8/16.
//  Copyright © 2016 Managam Silalahi. All rights reserved.
//

import XCTest
@testable import CleanStore

class CreateOrderViewControllerTests: XCTestCase {
    
    var createOrderViewController: CreateOrderViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        window = UIWindow()
        setupCreateOrderViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK - Test setup
    
    func setupCreateOrderViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        createOrderViewController = navigationController.topViewController as! CreateOrderViewController
        UIApplication.shared.keyWindow?.rootViewController = createOrderViewController
    }
    
    func addViewToWindow() {
        window.addSubview(createOrderViewController.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK - Test doubles
    
    class CreateOrderViewControllerOutputSpy: CreateOrderViewControllerOutput {
        // MARK - Method call expectations
        var formatExpirationDateCalled = false
        
        // MARK - Argument expectations
        var createOrder_formatExpirationDate_request: CreateOrder_FormatExpirationDate_Request!
        
        // MARK - Spied variables
        var shippingMethods = [String]()
        
        // MARK - Spied methods
        func formatExpirationDate(request: CreateOrder_FormatExpirationDate_Request) {
            formatExpirationDateCalled = true
            createOrder_formatExpirationDate_request = request
        }
    }
    
    // MARK - Test expiration date showed
    func testDisplayExpirationDateShouldDisplayDateStringInTextField() {
        // Given
        let viewModel = CreateOrder_FormatExpirationDate_ViewModel(date: "12/8/16")
        
        // When
        createOrderViewController.displayExpirationDate(viewModel: viewModel)
        
        print("hwohowh")
        
        // Then
        let displayedDate = createOrderViewController.expirationDateTextField.text
        XCTAssertEqual(displayedDate, "12/8/16", "Displaying an expiration date should display the date string in the expiration date text field")
    }
    
    // MARK - Test expiration date changed
    func testExpirationDatePickerValueChangedShouldFormatSelectedDate() {
        // Given
        let createOrderViewControllerOutputSpy = CreateOrderViewControllerOutputSpy()
        createOrderViewController.output = createOrderViewControllerOutputSpy
        
        let dateComponents: DateComponents = {
            var dateComponents = DateComponents()
            dateComponents.year = 2016
            dateComponents.month = 12
            dateComponents.day = 8
            
            return dateComponents
        }()
        
        let selectedDate = Calendar.current.date(from: dateComponents)!
        
        // When
        createOrderViewController.expirationDatePicker.date = selectedDate
        createOrderViewController.expirationDatePickerValueChanged(self)
        
        // Then
        XCTAssert(createOrderViewControllerOutputSpy.formatExpirationDateCalled, "Changing the expiration date should format the expiration date")
        let actualDate = createOrderViewControllerOutputSpy.createOrder_formatExpirationDate_request.date
        XCTAssertEqual(actualDate, selectedDate)
    }
    
    // MARK - Test shipping method
    func testNumberOfComponentsInPickerViewShouldReturnOneComponent() {
        // Given
        let pickerView = createOrderViewController.shippingMethodPicker!
        
        // When
        let numberOfComponents = createOrderViewController.numberOfComponents(in: pickerView)
        
        // Then
        XCTAssertEqual(numberOfComponents, 1, "The number of components in the shipping method picker should be 1")
    }
    
    func testNumberOfRowsInFirstComponentOfPickerViewShouldEqualNumberOfAvailableShippingMethods() {
        // Given
        let pickerView = createOrderViewController.shippingMethodPicker!
        
        // When
        let numberOfRows = createOrderViewController.pickerView(pickerView, numberOfRowsInComponent: 0)
        
        // Then
        let numberOfShippingMethods = createOrderViewController.output.shippingMethods.count
        XCTAssertEqual(numberOfRows, numberOfShippingMethods, "The number of rows in the first component of shipping method picker should equal to the number of available shipping methods")
    }
    
    func testShippingMethodsPickerShouldDisplayProperTitles() {
        // Given
        let pickerView = createOrderViewController.shippingMethodPicker!
        
        // When
        var returnedTitles = [String]()
        for i in 0...2 {
            returnedTitles.append(createOrderViewController.pickerView(pickerView, titleForRow: i, forComponent: 0)!)
        }
        
        // Then
        let expectedtitles = [
            "Standard Shipping",
            "Two-day Shipping",
            "One-day Shipping"
        ]
        for i in 0...2 {
            XCTAssertEqual(returnedTitles[i], expectedtitles[i], "The shipping method picker should display proper titles")
        }
        
    }
    
    func testSelectingShippingMethodInThePickerShouldDisplayTheSelectedShippingMethodToUser() {
        // Given
        let pickerView = createOrderViewController.shippingMethodPicker!
        
        // When
        createOrderViewController.pickerView(pickerView, didSelectRow: 2, inComponent: 0)
        
        // Then
        let expectedShippingMethod = "One-day Shipping"
        let displayedShippingMethod = createOrderViewController.shippingMethodTextField.text
        XCTAssertEqual(expectedShippingMethod, displayedShippingMethod, "Selecting a shipping method in the shipping method picker should display the selected shipping method to the user")
    }
}
