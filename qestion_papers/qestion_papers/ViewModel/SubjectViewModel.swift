//
//  SubjectViewModel.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 07/10/25.
//

import Foundation

class SubjectViewModel: ObservableObject {
    @Published var subjectList: [SubjectModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func fetchSubject(for subjectId: String) {
        isLoading = true
        errorMessage = nil
        
        let urlString = ApiConstant.Endpoints.subject + subjectId
        print("Fetching semesters from URL: --->\n \(urlString)")
        
        NetworkManager.shared.get(urlString: urlString, type: [SubjectModel].self) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let subject):
                    self.subjectList = subject
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
