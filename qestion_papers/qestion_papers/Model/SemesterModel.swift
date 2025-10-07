//
//  SemesterModel.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 08/10/25.
//

import Foundation


struct SemesterModel: Identifiable, Codable {
    let id: String
    let course: String
    let name: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case course
        case name
        case v = "__v"
    }
}
