//
//  PaperModel.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 08/10/25.
//

import Foundation

struct PaperModelResponse: Codable {
    let success: Bool
    let count: Int
    let papers: [PaperModel]
}

struct PaperModel: Identifiable, Codable {
    let id: String
    let subject: SubjectSummary
    let year: Int
    let pdfUrl: String
    let masterPdfUrl: String?
    let ytUrl: String?
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case subject
        case year
        case pdfUrl
        case masterPdfUrl
        case ytUrl
        case v = "__v"
    }
}

struct SubjectSummary: Codable {
    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}
