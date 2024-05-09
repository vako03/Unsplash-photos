//
//  ImageViewModel.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 09.05.24.
//
import Foundation

class ImageViewModel {
    var imageUrls: [String] = []
    
    func fetchImages(completion: @escaping () -> Void) {
        guard var urlComponents = URLComponents(string: APIService.unsplashAPIURL) else {
            return
        }
        
        urlComponents.query = "client_id=\(APIService.apiKey)&page=\(APIService.currentPage)&per_page=\(APIService.perPage)"
        
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
