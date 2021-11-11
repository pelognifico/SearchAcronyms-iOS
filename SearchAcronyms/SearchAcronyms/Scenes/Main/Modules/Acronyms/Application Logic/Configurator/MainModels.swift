//
//  MainModels.swift
//  SearchAcronyms
//
//  Created by Carlos Villamizar on 9/11/21.
//

import Foundation

enum Main {
    // MARK: Use cases
    enum SearchAcronyms {
        struct Request {
            let sf : String?
        }
        
        struct Response: Codable {
            // MARK: - DataClass
            struct DataClass: Codable {
            }
            let sf: String
            let lfs: [Lfs]
            
            enum CodingKeys: String, CodingKey {
                case sf
                case lfs
            }
        }
        
        struct ViewModel {
            let data: [Main.SearchAcronyms.Response]
            
        }
    }
    
    enum Error {
        struct Request {
        }
        struct Response {
            var error: MainError
        }
        struct ViewModel {
            var error: MainError
        }
    }
}
