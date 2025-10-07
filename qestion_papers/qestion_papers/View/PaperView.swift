//
//  PaperView.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 07/10/25.
//

import SwiftUI

struct PaperView: View {
    @StateObject private var paperVM = PaperViewModel()
    var paperId: String
    var title: String

    var body: some View {
        List {
            if paperVM.isLoading {
                Section {
                    HStack {
                        Spacer()
                        ProgressView("Loading Papers...")
                        Spacer()
                    }
                    .padding()
                }
            } else if let error = paperVM.errorMessage {
                Section {
                    VStack(alignment: .center, spacing: 8) {
                        Text("Error")
                            .font(.title3)
                            .bold()
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
            } else {
                ForEach(paperVM.papers) { paper in
                    if let url = URL(string: paper.pdfUrl) {
                        NavigationLink(destination: PDFViewer(url: url)
                            .navigationTitle("Year: \(String(paper.year))")) {
                            HStack(spacing: 12) {
                                Image(systemName: "doc.richtext")
                                    .foregroundColor(.blue)
                                    .font(.title2)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Year: \(String(paper.year))") // Just plain integer, no formatting
                                        .font(.headline)
//                                    Text(paper.pdfUrl)
//                                        .font(.caption)
//                                        .foregroundColor(.blue)
//                                        .lineLimit(1)
//                                        .truncationMode(.middle)
                                }
                            }
                            .padding(.vertical, 6)
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Year: \(paper.year)")
                                .font(.headline)
                            Text("Invalid PDF URL")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            paperVM.fetchPaper(for: paperId)
        }
        .onAppear {
            if paperVM.papers.isEmpty {
                paperVM.fetchPaper(for: paperId)
            }
        }
    }
}

#Preview {
    PaperView(paperId: "68e3efc8f9ca21b3ce54bbfe", title: "Subject Name")
}
