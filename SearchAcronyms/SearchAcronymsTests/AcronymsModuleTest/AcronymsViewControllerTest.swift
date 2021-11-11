//
//  AcronymsViewControllerTest.swift
//  SearchAcronymsTests
//
//  Created by Ruben Duarte on 11/11/21.
//

import XCTest
import Foundation
@testable import SearchAcronyms

class AcronymsViewControllerTest: XCTestCase {
    var sut: MainViewController!
    var viewControllerMock: AcronymsDisplayLogicMock!
    
    override func setUp() {
        super.setUp()
        
        viewControllerMock = AcronymsDisplayLogicMock()
        sut = MainViewController()
    }
    
    func testSearchAcronyms() {
        //Given
        let lfsResponseMock : [Lfs] = [.init(lf: "ABC", freq: 1, since: 1, vars: .none)]
        let responseMock = [Main.SearchAcronyms.Response(sf: "ABC", lfs: lfsResponseMock)]
        
        let viewModel = Main.SearchAcronyms.ViewModel(data: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        
        viewControllerMock.displaySearchAcronyms(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.searchAcronyms(word: "ABC")
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    
}
