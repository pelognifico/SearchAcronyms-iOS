//
//  MainRouter.swift
//  SearchAcronyms
//
//  Created by Carlos Villamizar on 9/11/21.
//

import Foundation

@objc protocol MainRoutingLogic {
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

class MainRouter: NSObject, MainRoutingLogic, MainDataPassing {
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?
  
}
