//
//  SemesterViewModel.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 07/10/25.
//

import Foundation

class SemesterViewModel: ObservableObject {
    
    @Published var semesters: [SemesterModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    func fetchSemesters(for courseId: String) {
        isLoading = true
        errorMessage = nil
        
        let urlString = ApiConstant.Endpoints.semester + courseId
        print("Fetching semesters from URL: \(urlString)")
        
        NetworkManager.shared.get(urlString: urlString, type: [SemesterModel].self) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let semesters):
                    self.semesters = semesters
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}


