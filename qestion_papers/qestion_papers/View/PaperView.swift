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
        Group {
            if paperVM.isLoading {
                VStack {
                    Spacer()
                    ProgressView("Loading Papers...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .padding()
                    Spacer()
                }
            } else if let error = paperVM.errorMessage {
                VStack(spacing: 10) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.orange)
                    Text("Error")
                        .font(.title3)
                        .bold()
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(maxWidth: .infinity)
            } else if paperVM.papers.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("No Papers Found")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("Try pulling down to refresh.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity)
            } else {
                List {
                    ForEach(paperVM.papers) { paper in
                        Section(header: Text("\(paper.subject.name) — \(paper.year)")
                            .font(.headline)
                        ) {

                            // 🧾 Paper PDF
                            if let pdfUrl = URL(string: paper.pdfUrl) {
                                NavigationLink(destination: PDFViewer(url: pdfUrl)
                                    .navigationTitle("Paper \(paper.year)")
                                    .navigationBarTitleDisplayMode(.inline)) {
                                    Label("Open Question Paper", systemImage: "doc.text")
                                        .foregroundColor(.blue)
                                }
                            }

                            // 🧠 Master Paper PDF (optional)
                            if let masterUrl = paper.masterPdfUrl,
                               let url = URL(string: masterUrl) {
                                NavigationLink(destination: PDFViewer(url: url)
                                    .navigationTitle("Master Paper \(paper.year)")
                                    .navigationBarTitleDisplayMode(.inline)) {
                                    Label("Open Master Paper", systemImage: "doc.richtext")
                                        .foregroundColor(.purple)
                                }
                            }

                            // 🎥 YouTube (optional)
                            if let ytUrl = paper.ytUrl,
                               let url = URL(string: ytUrl) {
                                Link(destination: url) {
                                    Label("Watch Solution Video", systemImage: "play.rectangle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
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
    PaperView(
        paperId: "68e3efc8f9ca21b3ce54bbfe",
        title: "Programming Principles"
    )
}
