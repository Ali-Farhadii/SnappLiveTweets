//
//  Rule.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/10/1401 AP.
//

import Foundation

struct Rule: Codable {
    let data: [RuleData]?
    let meta: RuleMeta
}

struct RuleData: Codable {
    let id: String
    let value: String
    let tag: String?
}

struct RuleMeta: Codable {
    let sent: String
}
