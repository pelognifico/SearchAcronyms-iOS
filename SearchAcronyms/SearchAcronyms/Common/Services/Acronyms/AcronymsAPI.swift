//
//  AcronymsAPI.swift
//  SearchAcronyms
//
//  Created by Carlos Villamizar on 9/11/21.
//

import Foundation

class AcronymsAPI: AcronymsServiceProtocol {
    // Comunication with EndPoint
    func searchAcronyms(request: Main.SearchAcronyms.Request, completion: @escaping (Result<[Main.SearchAcronyms.Response], MainError>) -> Void) {
        
        NetworkService.share.request(endpoint: AcronymsEndpoint.searchAcronyms(parameter: request.sf ?? "")) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode([Main.SearchAcronyms.Response].self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
}
