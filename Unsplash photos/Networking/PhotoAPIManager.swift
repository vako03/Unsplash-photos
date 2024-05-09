//
//  PhotoAPIManager.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 09.05.24.
//
import Foundation

class PhotoAPIManager {
    func fetchImages(completion: @escaping ([String]) -> Void) {
        guard var urlComponents = URLComponents(string: APIService.unsplashAPIURL) else {
            completion([])
            return
        }
        
        urlComponents.query = "client_id=\(APIService.apiKey)&page=\(APIService.currentPage)&per_page=\(APIService.perPage)"
        
        guard let url = urlComponents.url else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching images: \(error)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion([])
                return
            }
            
            do {
                let unsplashResponses = try JSONDecoder().decode([UnsplashResponse].self, from: data)
                let newImageUrls = unsplashResponses.compactMap { $0.urls["regular"] }
                
                completion(newImageUrls)
            } catch {
                print("Error decoding JSON: \(error)")
                completion([])
            }
        }.resume()
    }
}
