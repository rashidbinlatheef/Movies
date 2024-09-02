//
//  RatingView.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int?
    
    private func startType(index: Int) -> String {
        if let rating {
            return index <= rating ? "star.fill": "star"
        } else {
            return "star"
        }
    }
    var body: some View {
        HStack {
            ForEach(1...10, id: \.self) { index in
                Image(systemName: startType(index: index))
                    .foregroundColor(Color(.orange))
                    .onTapGesture {
                        self.rating = index
                    }
            }
        }
        
    }
}

#Preview {
    RatingView(rating: .constant(5))
}
