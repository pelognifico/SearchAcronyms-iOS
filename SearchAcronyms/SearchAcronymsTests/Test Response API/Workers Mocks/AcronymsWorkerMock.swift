//
//  AcronymsWorkerMock.swift
//  SearchAcronymsTests
//
//  Created by Ruben Duarte on 10/11/21.
//

import Foundation
@testable import SearchAcronyms

class AcronymsWorkerMock : AcronymsServiceProtocol {
    var resultSearchAcronyms: (Result<[Main.SearchAcronyms.Response], MainError>)?
    
    var isFunctionWasCalled = false
    
    func searchAcronyms(request: Main.SearchAcronyms.Request, completion: @escaping (Result<[Main.SearchAcronyms.Response], MainError>) -> Void) {
        if let result = resultSearchAcronyms {
            isFunctionWasCalled = true
            completion(result)
        }
    }
}
