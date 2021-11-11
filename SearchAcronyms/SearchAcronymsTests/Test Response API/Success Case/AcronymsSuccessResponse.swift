//
//  AcronymsSuccessResponse.swift
//  SearchAcronymsTests
//
//  Created by Ruben Duarte on 10/11/21.
//

import XCTest
@testable import SearchAcronyms

class AcronymsSuccessResponse: XCTestCase {
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
        let lfsResponseMock : [Lfs] = [.init(lf: "ABC", freq: 1, since: 1, vars: .none)]
        let dataMock = Main.SearchAcronyms.Response(sf: "ABC", lfs: lfsResponseMock)
        let success : [Main.SearchAcronyms.Response]? = .some([dataMock])
        
        //When
        acronymsServiceProtocolMock.resultSearchAcronyms = .success(success!)
        
        //Then
        sut.searchAcronyms(request: requestData, completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertNotNil(response[0].lfs)
                XCTAssertEqual(response[0].sf, dataMock.sf)
                XCTAssertEqual(response[0].lfs.count, dataMock.lfs.count)
            case .failure(_):
                break
            }
        })
    }
}
