//
//  SubjectModel.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 07/10/25.
//

import Foundation

struct SubjectModel: Identifiable, Codable {
    let id: String            // Maps from "_id"
    let semester: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case semester
        case name
    }
}

