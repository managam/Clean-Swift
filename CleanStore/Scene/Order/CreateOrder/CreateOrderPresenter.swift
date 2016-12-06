//
//  CreateOrderPresenter.swift
//  CleanStore
//
//  Created by Managam Silalahi on 12/6/16.
//  Copyright (c) 2016 Managam Silalahi. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol CreateOrderPresenterInput
{
    func presentExpirationDate(response: CreateOrder_FormatExpirationDate_Response)
}

protocol CreateOrderPresenterOutput: class
{
    func displayExpirationDate(viewModel: CreateOrder_FormatExpirationDate_ViewModel)
}

class CreateOrderPresenter: CreateOrderPresenterInput
{
    weak var output: CreateOrderPresenterOutput!
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    // MARK: - Expiration date
    
    func presentExpirationDate(response: CreateOrder_FormatExpirationDate_Response) {
        let date = dateFormatter.string(from: response.date as Date)
        let viewModel = CreateOrder_FormatExpirationDate_ViewModel(date: date)
        output.displayExpirationDate(viewModel: viewModel)
    }
}
