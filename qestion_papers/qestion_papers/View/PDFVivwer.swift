//
//  PDFVivwer.swift
//  qestion_papers
//
//  Created by Neeraj Dahit on 07/10/25.
//

import SwiftUI
import PDFKit

struct PDFViewer: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        
        // Load PDF in background
        DispatchQueue.global(qos: .background).async {
            if let document = PDFDocument(url: url) {
                DispatchQueue.main.async {
                    pdfView.document = document
                }
            } else {
                print("Failed to load PDF from URL: \(url)")
            }
        }
        
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // No dynamic update needed
    }
}


