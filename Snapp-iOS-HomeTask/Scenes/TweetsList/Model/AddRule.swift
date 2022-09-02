//
//  AddRule.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/10/1401 AP.
//

import Foundation

struct AddRule: Codable {
    let add: [AddRuleData]
}

struct AddRuleData: Codable {
    let value: String
    let tag: String
}
