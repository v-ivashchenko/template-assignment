//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import SwiftUI

struct TopRatedMoviesDetailView: View {
    
    let viewModel: TopRatedMoviesDetailViewModel
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                realView(image: image)
            } else {
                placeholderView
            }
        }
        .padding(Design.defaultPadding)
    }
    
    // MARK: - Private properties
    private var cornerRadius: CGFloat { 24 }
    private var foregroundColor: some ShapeStyle { .gray.opacity(0.25) }
    
    private func realView(image: UIImage) -> some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 450)
            
            Text(viewModel.title)
                .font(.title)
            
            UserScoreRatingViewRepresentable(value: viewModel.rating)
                .frame(width: 48, height: 48)
            
            Spacer()
        }
    }
    
    private var placeholderView: some View {
        VStack(alignment: .leading) {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 128)
            }
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(height: 25)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width: 300, height: 25)
            
            Spacer()
        }
        .foregroundStyle(foregroundColor)
    }
}

#Preview {
    Group {
        TopRatedMoviesDetailView(
            viewModel: .init(
                title: "A title",
                image: UIImage(systemName: "photo"),
                rating: 7.5
            )
        )
        
        TopRatedMoviesDetailView(
            viewModel: .init(
                title: "A title",
                image: UIImage(systemName: "photo2"),
                rating: 7.5
            )
        )
    }
}
