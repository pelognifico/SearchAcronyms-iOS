//
//  AcronymsInteractorTest.swift
//  SearchAcronymsTests
//
//  Created by Ruben Duarte on 11/11/21.
//

import XCTest
import Foundation
@testable import SearchAcronyms

class AcronymsInteractorTest: XCTestCase {
    var sut: MainInteractor!
    var acronymsPresenterMock: AcronymsWorkerMock!
    
    override func setUp() {
        acronymsPresenterMock = AcronymsWorkerMock()
        sut = MainInteractor(worker: acronymsPresenterMock)
    }
    
    func testAcronymsSuccess() {
        //Given
        let requestData = Main.SearchAcronyms.Request(sf: "ABC")
        let lfsResponseMock : [Lfs] = [.init(lf: "ABC", freq: 1, since: 1, vars: .none)]
        let responseMock = [Main.SearchAcronyms.Response(sf: "ABC", lfs: lfsResponseMock)]
        
        acronymsPresenterMock.resultSearchAcronyms = .success(responseMock)
        acronymsPresenterMock.isFunctionWasCalled = false
        
        //When
        sut.searchAcronyms(request: requestData)
        let result = acronymsPresenterMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue(result)
    }
    
    func testAcronymsFailure() {
        //Given
        let requestData = Main.SearchAcronyms.Request(sf: "ABC")
        let failure : MainError = .request
        
        acronymsPresenterMock.resultSearchAcronyms = .failure(failure)
        acronymsPresenterMock.isFunctionWasCalled = false
        
        //When
        sut.searchAcronyms(request: requestData)
        let result = acronymsPresenterMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue(result)
    }
}
