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
        Group {
            if courseVM.isLoading {
                ProgressView("Loading...")
            } else if let error = courseVM.errorMessage {
                Text(error)
            } else {
                List(courseVM.courses) { item in
                    NavigationLink(destination: SemesterView(courseId: item.id, title: item.name)) {
                        Text(item.name)
                    }
                }
            }
        }
        .onAppear() {
            if courseVM.courses.isEmpty {
                courseVM.fetchCourse()
            }
        }
        .navigationTitle("Courses")
    }
}

#Preview {
    CourseView()
}
