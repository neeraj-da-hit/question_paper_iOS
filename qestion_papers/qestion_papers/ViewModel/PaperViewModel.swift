//
//  PaperViewModel.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 07/10/25.
//

import Foundation

class PaperViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var papers: [PaperModel] = []  // Change to array of PaperModel
    
    func fetchPaper(for subjectId: String) {
        isLoading = true
        errorMessage = nil
        
        let urlString = ApiConstant.Endpoints.papers + subjectId
        print("Fetching papers from URL: --->\n \(urlString)")
        
        NetworkManager.shared.get(urlString: urlString, type: PaperModelResponse.self) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.papers = data.papers  // extract papers array
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

