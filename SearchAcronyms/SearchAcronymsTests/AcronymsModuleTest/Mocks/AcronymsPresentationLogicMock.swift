//
//  AcronymsPresentationLogicMock.swift
//  SearchAcronymsTests
//
//  Created by Ruben Duarte on 11/11/21.
//

import Foundation
@testable import SearchAcronyms

final class AcronymsPresentationLogicMock: MainPresentationLogic {
    var responseAcronyms: [Main.SearchAcronyms.Response]?
    var isFunctionWasCalled = false
    
    func presentSearchAcronyms(response: [Main.SearchAcronyms.Response]) {
        if responseAcronyms != nil {
            isFunctionWasCalled = true
        }
    }
    
    func presentError(response: Main.Error.Response) {
        isFunctionWasCalled = true
    }
}
