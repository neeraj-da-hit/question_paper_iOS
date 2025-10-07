//
//  PaperModel.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 07/10/25.
//

import Foundation

struct PaperModel: Identifiable, Codable {
    let id: String
    let year: Int
    let pdfUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case year
        case pdfUrl
    }
}

