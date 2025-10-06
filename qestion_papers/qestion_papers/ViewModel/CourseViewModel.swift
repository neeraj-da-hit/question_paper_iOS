//
//  CourseViewModel.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 06/10/25.
//

import Foundation

class CourseViewModel: ObservableObject {
    
    @Published var courses: [CourseModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func fetchCourse() {
        isLoading = true
        errorMessage = nil
        NetworkManager.shared.get(urlString: ApiConstant.Endpoints.courses, type: [CourseModel].self) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let courses):
                    self.courses = courses
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
