//
//  SubjectsView.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 07/10/25.
//

import SwiftUI

struct SubjectsView: View {
    @StateObject private var subjectVM = SubjectViewModel()
    var subjectId: String
    var title:String
    var body: some View {
        Group {
            if subjectVM.isLoading {
                ProgressView("Loading Subjects...")
            } else if let error = subjectVM.errorMessage {
                Text("something went wrong: \(error)")
            } else {
                List(subjectVM.subjectList) { item in
                    NavigationLink(destination: PaperView(title: item.name, paperId: item.id)) {
                        Text(item.name)
                    }
                }
                .refreshable {
                    subjectVM.fetchSubject(for: subjectId)
                }
            }
        }
        .onAppear {
            if subjectVM.subjectList.isEmpty {
                subjectVM.fetchSubject(for: subjectId)
            }
        }
        .navigationTitle(title)
    }
}

#Preview {
    SubjectsView(subjectId: "68e3efc8f9ca21b3ce54bbfe", title: "sme1")
}
