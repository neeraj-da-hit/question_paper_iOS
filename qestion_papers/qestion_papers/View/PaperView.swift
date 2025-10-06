//
//  PaperView.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 07/10/25.
//

import SwiftUI

struct PaperView: View {
    @StateObject private var paperVM = PaperViewModel()
    var title: String
    var paperId: String

    var body: some View {
        Group {
            if paperVM.isLoading {
                ProgressView("Loading Papers...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else if let error = paperVM.errorMessage {
                VStack(spacing: 12) {
                    Text("Something went wrong:")
                        .font(.headline)
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)

                    Button("Retry") {
                        paperVM.fetchPaper(for: paperId)
                    }
                    .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                List(paperVM.papers) { item in
                    if let url = URL(string: item.pdfUrl) {
                        NavigationLink(destination: PDFViewer(url: url).navigationTitle("Year: \(item.year)")) {
                            VStack(alignment: .leading) {
                                Text("Paper Year: \(item.year)")
                                    .font(.headline)
                            }
                        }
                    } else {
                        VStack(alignment: .leading) {
                            Text("Paper Year: \(item.year)")
                            Text("Invalid PDF URL")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                }
            }
        }
        .onAppear {
            paperVM.fetchPaper(for: paperId)
        }
        .navigationTitle(title)
    }
}


#Preview {
    PaperView(title: "subject name",paperId: "68e3efc8f9ca21b3ce54bbfe")
}
