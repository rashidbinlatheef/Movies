//
//  URLImage.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import SwiftUI

struct URLImage: View {
    let url: String
    @ObservedObject private var imageDownloader: ImageDownloader = ImageDownloader()
    
    init(url: String) {
        self.url = url
        imageDownloader.downloadImage(url: url)
    }
    
    var body: some View {
        if let imageData = imageDownloader.downloaderData, let image = UIImage(data: imageData) {
            return Image(uiImage: image).resizable()
        } else {
            return Image("placeHolder").resizable()
        }
    }
}
