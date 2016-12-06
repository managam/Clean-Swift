//
//  CreateOrderConfigurator.swift
//  CleanStore
//
//  Created by Managam Silalahi on 12/6/16.
//  Copyright (c) 2016 Managam Silalahi. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension CreateOrderViewController: CreateOrderPresenterOutput
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    router.passDataToNextScene(segue: segue)
  }
}

extension CreateOrderInteractor: CreateOrderViewControllerOutput
{
}

extension CreateOrderPresenter: CreateOrderInteractorOutput
{
}

class CreateOrderConfigurator
{
  // MARK: - Object lifecycle
  
  static let sharedInstance = CreateOrderConfigurator()
  
  private init() {}
  
  // MARK: - Configuration
  
  func configure(viewController: CreateOrderViewController)
  {
    let router = CreateOrderRouter()
    router.viewController = viewController
    
    let presenter = CreateOrderPresenter()
    presenter.output = viewController
    
    let interactor = CreateOrderInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}