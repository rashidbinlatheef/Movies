//
//  ImageDownloader.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import Foundation

class ImageDownloader: ObservableObject {
    @Published var downloaderData: Data? = nil
    
    func downloadImage(url: String) {
        guard let imageURL = URL(string: url) else {
            fatalError("imageURL")
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async { [weak self] in
                self?.downloaderData = data
            }
        }
    }
}
