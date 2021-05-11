//
//  NetworkManager.swift
//  Hacker Mobile News
//
//  Created by Mario Elorza on 07-05-21.
//

import Foundation

class NetworkManager {
    private let baseURL = "https://hn.algolia.com"
    
    func getMobileNews(completed: @escaping (Result<[StoryServerModel], NetworkError>) -> Void) {
        let path = "/api/v1/search_by_date?query=mobile"
        let endpoint = baseURL + path
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let response = try decoder.decode(HNResponse.self, from: data)
                completed(.success(response.hits))
            } catch {
                print(error)
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
}
