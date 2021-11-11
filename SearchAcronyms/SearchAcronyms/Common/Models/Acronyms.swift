//
//  Main.swift
//  SearchAcronyms
//
//  Created by Carlos Villamizar on 9/11/21.
//

import UIKit
import Foundation

// MARK: - Response Acronyms
struct Lfs: Codable {
    let lf      : String?
    let freq    : Int?
    let since   : Int?
    let vars    : [Vars]?
}

struct Vars: Codable {
    let lf      : String?
    let freq    : Int?
    let since   : Int?
}

