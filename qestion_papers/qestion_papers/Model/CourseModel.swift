//
//  CourseModel.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 06/10/25.
//

import Foundation

struct CourseModel: Identifiable, Codable {
    let id: String
    let name: String
    let v: Int

    // Map JSON keys to Swift properties
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case v = "__v"
    }
}

