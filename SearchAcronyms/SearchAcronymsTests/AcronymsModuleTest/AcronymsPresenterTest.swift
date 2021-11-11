//
//  AcronymsPresenterTest.swift
//  SearchAcronymsTests
//
//  Created by Ruben Duarte on 11/11/21.
//

import XCTest
import Foundation
@testable import SearchAcronyms

class AcronymsPresenterTest: XCTestCase {
    var sut: MainPresenter!
    var viewControllerMock: AcronymsDisplayLogicMock!
    
    override func setUp() {
        viewControllerMock = AcronymsDisplayLogicMock()
        sut = MainPresenter()
        sut.viewController = viewControllerMock
    }
    
    func testPresentAcronymsSuccess() {
        //Given
        let lfsResponseMock : [Lfs] = [.init(lf: "ABC", freq: 1, since: 1, vars: .none)]
        let responseMock = [Main.SearchAcronyms.Response(sf: "ABC", lfs: lfsResponseMock)]
        
        let viewModel = Main.SearchAcronyms.ViewModel(data: [])
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displaySearchAcronyms(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentSearchAcronyms(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    func testPresentAcronymsFailure() {
        //Given
        let error: MainError = .request
        let responseMock = Main.Error.Response(error: error)
        let viewModel = Main.Error.ViewModel(error: error)
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayError(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentError(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
}
