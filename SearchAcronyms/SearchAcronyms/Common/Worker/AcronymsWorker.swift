//
//  AcornymsWorker.swift
//  SearchAcronyms
//
//  Created by Carlos Villamizar on 9/11/21.
//

import Foundation

protocol AcronymsServiceProtocol {
    func searchAcronyms(request: Main.SearchAcronyms.Request, completion: @escaping (Result<[Main.SearchAcronyms.Response], MainError>) -> Void)
}

class AcronymsWorker: AcronymsServiceProtocol{
    var acronymsService: AcronymsServiceProtocol
    
    init(acronymsService: AcronymsServiceProtocol = AcronymsAPI()) {
        self.acronymsService = acronymsService
    }
    
    // Request the data
    func searchAcronyms(request: Main.SearchAcronyms.Request, completion: @escaping (Result<[Main.SearchAcronyms.Response], MainError>) -> Void) {
        acronymsService.searchAcronyms(request: request, completion: { result in
            completion(result)
        })
    }
}
