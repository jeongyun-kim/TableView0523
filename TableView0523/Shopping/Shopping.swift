//
//  Shopping.swift
//  TableView0523
//
//  Created by 김정윤 on 7/20/24.
//

import Foundation

struct Shopping: Hashable, Identifiable {
    let id = UUID() 
    let productName: String
    var isComplete: Bool = false
}
