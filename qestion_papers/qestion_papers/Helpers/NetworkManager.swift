//
//  NetworkManager.swift
//  shoping api
//
//  Created by Neeraj Dahit on 06/10/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .noData:
            return "No data was received from the server."
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    /// Fetches and decodes data from a given URL, with pretty-printed JSON debug output
    /// - Parameters:
    ///   - urlString: The URL string to fetch data from
    ///   - type: The Codable type to decode into
    ///   - completion: Completion handler with Result
    func get<T: Codable>(urlString: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            debugPrint(NetworkError.invalidURL.localizedDescription)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                debugPrint("Network error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                debugPrint(NetworkError.noData.localizedDescription)
                return
            }

            // Debug: Print readable JSON
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                debugPrint("Raw JSON Response:------------------------------------->\n\(prettyString)")
            } else {
                debugPrint("Could not pretty print JSON, raw data: \(String(data: data, encoding: .utf8) ?? "")")
            }

            do {
                let decoded = try JSONDecoder().decode(type, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
                debugPrint("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
