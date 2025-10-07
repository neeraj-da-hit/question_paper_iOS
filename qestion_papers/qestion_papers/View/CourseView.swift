//
//  CourseView.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 06/10/25.
//

import SwiftUI

struct CourseView: View {
    
    @StateObject private var courseVM = CourseViewModel()
    
    var body: some View {
        List {
            if courseVM.isLoading {
                Section {
                    HStack {
                        Spacer()
                        ProgressView("Loading...")
                        Spacer()
                    }
                }
            } else if let error = courseVM.errorMessage {
                Section {
                    Text(error)
                        .foregroundColor(.red)
                }
            } else {
                ForEach(courseVM.courses) { item in
                    NavigationLink(destination: SemesterView(courseId: item.id, title: item.name)) {
                        Text(item.name)
                    }
                }
            }
        }
        .navigationTitle("Courses")
        .refreshable {
            courseVM.fetchCourse()
        }
        .onAppear {
            if courseVM.courses.isEmpty {
                courseVM.fetchCourse()
            }
        }
    }
}


#Preview {
    CourseView()
}
