//
//  MainInteractor.swift
//  SearchAcronyms
//
//  Created by Carlos Villamizar on 9/11/21.
//

import Foundation

protocol MainBusinessLogic {
    func searchAcronyms(request: Main.SearchAcronyms.Request)
}

protocol MainDataStore {
}

class MainInteractor: MainBusinessLogic, MainDataStore {
    
    var presenter: MainPresentationLogic?
    
    var worker: AcronymsServiceProtocol
     
    init(worker: AcronymsServiceProtocol = AcronymsWorker()) {
        self.worker = worker
    }
    
    // MARK: - Methods
    // Handling the request and will return a response object to the Presenter.
    func searchAcronyms(request: Main.SearchAcronyms.Request) {
        worker.searchAcronyms(request: request, completion: { result in
            switch result {
            case .success(let response):
                self.presenter?.presentSearchAcronyms(response: response)
            case .failure(let error):
                let response = Main.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        })
    }
}
