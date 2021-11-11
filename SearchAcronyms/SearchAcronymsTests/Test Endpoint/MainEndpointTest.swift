//
//  MainEndpointTest.swift
//  SearchAcronymsTests
//
//  Created by Ruben Duarte on 10/11/21.
//

import XCTest
@testable import SearchAcronyms

class MainEndpointTest: XCTestCase {
    var sut: AcronymsEndpoint!
    
    //MARK: - GET METHOD
    
    func testSearchAcronyms() {
        sut = .searchAcronyms(parameter: "")

        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.path, "?sf=")
        XCTAssertNil(sut.parameter)
    }
}
