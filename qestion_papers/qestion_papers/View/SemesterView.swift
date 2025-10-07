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
        List {
            if semVM.isLoading {
                Section {
                    HStack {
                        Spacer()
                        ProgressView("Loading Semesters...")
                        Spacer()
                    }
                }
            } else if let error = semVM.errorMessage {
                Section {
                    Text(error)
                        .foregroundColor(.red)
                }
            } else {
                ForEach(semVM.semesters) { item in
                    NavigationLink(destination: SubjectsView(subjectId: item.id, title: item.name)) {
                        Text(item.name)
                    }
                }
            }
        }
        .navigationTitle(title)
        .refreshable {
            semVM.fetchSemesters(for: courseId)
        }
        .onAppear {
            if semVM.semesters.isEmpty {
                semVM.fetchSemesters(for: courseId)
            }
        }
    }
}


#Preview {
    SemesterView(courseId: "68e3ec0ef9ca21b3ce54bbe2", title: "BCA")
}
