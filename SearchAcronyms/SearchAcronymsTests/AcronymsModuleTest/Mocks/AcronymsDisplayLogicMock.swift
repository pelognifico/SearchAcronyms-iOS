//
//  AcronymsDisplayLogicMock.swift
//  SearchAcronymsTests
//
//  Created by Ruben Duarte on 11/11/21.
//

import Foundation
@testable import SearchAcronyms

final class AcronymsDisplayLogicMock: MainDisplayLogic {
    var viewModelDisplayAcronyms: Main.SearchAcronyms.ViewModel?

    var isFunctionWasCalled = false
    
    func displaySearchAcronyms(viewModel: Main.SearchAcronyms.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
    
    func displayError(viewModel: Main.Error.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
}
