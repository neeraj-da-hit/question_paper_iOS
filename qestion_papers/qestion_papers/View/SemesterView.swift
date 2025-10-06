//
//  SemesterView.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 07/10/25.
//

import SwiftUI

struct SemesterView: View {
    @StateObject private var semVM = SemesterViewModel()
    var courseId: String
    var title: String
    var body: some View {
        Group {
            if semVM.isLoading {
                ProgressView("Loading Semesters...")
            } else if let error = semVM.errorMessage {
                Text(error)
            } else {
                List(semVM.semesters) { item in
                    NavigationLink(destination: SubjectsView(subjectId: item.id, title: item.name)) {
                        Text(item.name)
                    }
                }
            }
        }
        .onAppear {
            if semVM.semesters.isEmpty {
                semVM.fetchSemesters(for: courseId)
            }
        }
        .navigationTitle(title)
    }
}

#Preview {
    SemesterView(courseId: "68e3ec0ef9ca21b3ce54bbe2", title: "BCA")
}
