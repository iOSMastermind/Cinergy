//
//  MovieDetailView.swift
//  Cinergy
//
//  Created by Jinu on 25/08/2024.
//

import SwiftUI
import Kingfisher
struct MovieDetailView: View {
    var room : EscapeRoom
    var user: User
    @Environment(\.presentationMode) var presentationMode
    @State private var isBookingSheetPresented = false
    let requestService = RequestServices() // Actual implementation of RequestServiceProtocol

    var body: some View {
        NavigationStack {
            
            VStack {
                // Close button at the top left with a smaller size
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.gray.opacity(0.8))
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 8)
                .padding(.trailing)
                .padding(.bottom)
                
                HStack(alignment: .top) {
                    KFImage(URL(string: "\(room.imageUrl)"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(alignment: .leading) {
                        Text(room.title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundStyle(Color(hex: "#A2C658"))
                                .layoutPriority(1)
                            Text("\(room.runTime) minutes")
                                .font(.caption)
                                .layoutPriority(1)
//                            Spacer()
                            Image(systemName: "person")
                                .layoutPriority(1)
                                .foregroundStyle(Color(hex: "#A2C658"))
                            Text("up to 8 people")
                                .font(.caption)
                                .layoutPriority(1)
                        }
                        
                        // Scrollable synopsis text
                        ScrollView {
                            Text(room.synopsis)
                                .font(.body)
                                .padding(.horizontal, 4)
                        }
                        .frame(height: 200) // Set the height for the ScrollView
                    }
                }
                HStack {
                    Button(action: {
                        isBookingSheetPresented = true

                    }) {
                        Text("Book Now")
                            .fontWeight(.semibold)
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 240, height: 40) // Adjust width and height if needed
                            .background(Color(hex: "#A2C658")) // Background color
                            .cornerRadius(10) // Rounded corners
                    }
                    .sheet(isPresented: $isBookingSheetPresented) {
                        MovieBookingScreen(viewModel: MovieBookingViewModel(movie: room, user: user, requestService: requestService))
                                }
                    Button(action: {
                        // Action to perform
                    }) {
                        HStack { // Aligns the image and text horizontally
                            Image(systemName: "info.square.fill") // Use an SF Symbol image
                            Text("More")
                                .fontWeight(.semibold)
                        }
                        
                        .frame(width: 100, height: 40)
                        .foregroundColor(Color(hex: "#A2C658")) // Text and image color
                        .cornerRadius(10) // Rounded corners
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity) // Ensures HStack uses all available width
                
                Spacer()
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}
