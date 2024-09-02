//
//  Constants.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import Foundation

struct Constants {
    static let apiKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API_KEY is missing from Info.plist")
        }
        return key
    }()
}
