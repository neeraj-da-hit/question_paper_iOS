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
    var title: String

    var body: some View {
        List {
            if subjectVM.isLoading {
                Section {
                    HStack {
                        Spacer()
                        ProgressView("Loading Subjects...")
                        Spacer()
                    }
                }
            } else if let error = subjectVM.errorMessage {
                Section {
                    Text("Something went wrong: \(error)")
                        .foregroundColor(.red)
                }
            } else {
                ForEach(subjectVM.subjectList) { item in
                    NavigationLink(destination: PaperView(paperId: item.id, title: item.name)) {
                        Text(item.name)
                    }
                }
            }
        }
        .navigationTitle(title)
        .refreshable {
            subjectVM.fetchSubject(for: subjectId)
        }
        .onAppear {
            if subjectVM.subjectList.isEmpty {
                subjectVM.fetchSubject(for: subjectId)
            }
        }
    }
}


#Preview {
    SubjectsView(subjectId: "68e3efc8f9ca21b3ce54bbfe", title: "sme1")
}
