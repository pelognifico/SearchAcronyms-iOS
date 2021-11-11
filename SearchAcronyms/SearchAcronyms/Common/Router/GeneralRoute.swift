//
//  GeneralRoute.swift
//  SearchAcronyms
//
//  Created by Carlos Villamizar on 9/11/21.
//

import Foundation
import UIKit

enum GeneralRoute: IRouter {
    case main
}

extension GeneralRoute {
    var scene: UIViewController? {
        switch self {
        case .main:
            return MainViewController()
        }
    }
}
