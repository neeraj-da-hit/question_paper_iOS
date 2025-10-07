//
//  SubjectModel.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 08/10/25.
//

import Foundation

import Foundation

struct SubjectModel: Identifiable, Codable {
    let id: String
    let semester: String
    let name: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case semester
        case name
        case v = "__v"
    }
}
