//
//  ImageViewModel.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 09.05.24.
//
import Foundation

class ImageViewModel {
    var imageUrls: [String] = []
    let unsplashAPIURL = "https://api.unsplash.com/photos/"
    let apiKey = "CTmtSaHCKX7ITD5k-1hmAMVxjtC4iDXwFYRWQQPUAwQ"
    let perPage = 33
    var currentPage = 1
    
    func fetchImages(completion: @escaping () -> Void) {
        guard var urlComponents = URLComponents(string: unsplashAPIURL) else {
            return
        }
        
        urlComponents.query = "client_id=\(apiKey)&page=\(currentPage)&per_page=\(perPage)"
        
        guard let url = urlComponents.url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching images: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let unsplashResponses = try JSONDecoder().decode([UnsplashResponse].self, from: data)
                let newImageUrls = unsplashResponses.compactMap { $0.urls["regular"] }
                
                self.imageUrls.append(contentsOf: newImageUrls)
                
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

struct UnsplashResponse: Codable {
    let urls: [String: String]
}
