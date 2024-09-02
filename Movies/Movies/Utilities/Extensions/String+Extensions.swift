//
//  String+Extensions.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import Foundation

extension String {
    func urlEncode() -> String {
        addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? self
    }
}
