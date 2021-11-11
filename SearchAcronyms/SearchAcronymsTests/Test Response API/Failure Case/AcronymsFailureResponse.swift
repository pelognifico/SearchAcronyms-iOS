//
//  AcronymsFailureResponse.swift
//  SearchAcronymsTests
//
//  Created by Ruben Duarte on 10/11/21.
//

import XCTest
@testable import SearchAcronyms

class AcronymsFailureResponse: XCTestCase {
    var sut: AcronymsWorker!
    var acronymsServiceProtocolMock: AcronymsWorkerMock!
    
    override func setUp() {
        acronymsServiceProtocolMock = AcronymsWorkerMock()
        sut = AcronymsWorker(acronymsService: acronymsServiceProtocolMock)
    }
    
    //MARK: -- Test SearchAcronyms
    func testSearchAcronyms(){
        //Given
        let requestData = Main.SearchAcronyms.Request(sf: "ABC")
        let failure : MainError = .request
        
        //When
        acronymsServiceProtocolMock.resultSearchAcronyms = .failure(failure)
        
        //Then
        sut.searchAcronyms(request: requestData, completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, failure.localizedDescription)
            }
        })
    }
}
