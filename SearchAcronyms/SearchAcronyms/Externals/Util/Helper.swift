//
//  Helper.swift
//  SearchAcronyms
//
//  Created by Carlos Villamizar on 9/11/21.
//

import Foundation
import UIKit

struct Helper {
    
    static func apiBaseUrl()->String{
        let env : String = Bundle.main.infoDictionary?["API_BASE_URL"] as? String ?? ""
        return env
    }
}

protocol HomeControllerDelegate {
    func handleMenuToggle()
}
