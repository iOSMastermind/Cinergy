//
//  MovieCellView.swift
//  Cinergy
//
//  Created by Jinu on 25/08/2024.
//

import SwiftUI
import Kingfisher
struct MovieCellView: View {
    @ObservedObject var viewModel: MovieCellViewModel

//    var room: EscapeRoom1
    
    init(viewModel: MovieCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
                    GeometryReader{ proxy in
                        KFImage(URL(string: "\(viewModel.escapeRoomsMovie.imageUrl)"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.frame(in: .global).width,height: 250)

                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(height: 250)
                Text(viewModel.escapeRoomsMovie.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
        }
    }
}


