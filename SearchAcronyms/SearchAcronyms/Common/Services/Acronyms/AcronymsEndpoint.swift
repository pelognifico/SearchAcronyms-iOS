//
//  AcronymsEndpoint.swift
//  SearchAcronyms
//
//  Created by Carlos Villamizar on 9/11/21.
//

import Alamofire
import Foundation

enum AcronymsEndpoint {
    case searchAcronyms(parameter: String)
}

extension AcronymsEndpoint: SAEndpoint {
    var method: HTTPMethod {
        switch self {
        case .searchAcronyms:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .searchAcronyms(let parameter):
            return "?sf=\(parameter)"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .searchAcronyms:
            return nil
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .searchAcronyms:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
