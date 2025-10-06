//
//  ApiConstant.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 06/10/25.
//

import Foundation


struct ApiConstant {
    static let baseURL = "https://exam-buddy-yaya.onrender.com"

    struct Endpoints {
        static let courses = "\(ApiConstant.baseURL)/api/course/"
        static let semester = "\(ApiConstant.baseURL)/api/semester/"
        static let subject = "\(ApiConstant.baseURL)/api/subject/"
        static let papers = "\(ApiConstant.baseURL)/api/paper/"
        // Add more endpoints here
    }
}
