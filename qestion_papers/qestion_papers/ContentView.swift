//
//  ContentView.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 06/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                CourseView()
            }
            .tabItem {
                Label("Courses", systemImage: "book.closed")
            }
            NavigationStack {
                BookmarkView()
            }
            .tabItem {
                Label("Courses", systemImage: "bookmark")
            }
        }
    }
}

#Preview {
    ContentView()
}
