//
//  DeleteRule.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/10/1401 AP.
//

import Foundation

struct DeleteRule: Codable {
    var delete: DeleteRuleData
}

struct DeleteRuleData: Codable {
    var values: [String]
}

struct DeleteRuleResponse: Codable {
    var meta: DeleteMeta
}

struct DeleteMeta: Codable {
    var sent: String
}
