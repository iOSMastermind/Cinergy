//
//  MovieBookingScreen.swift
//  Cinergy
//
//  Created by Jinu on 26/08/2024.
//

import SwiftUI
import Kingfisher

struct MovieBookingScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MovieBookingViewModel

    init(viewModel: MovieBookingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        if let movieInfo = viewModel.movieDetail?.movieInfo {
        VStack {
            // Navigation Bar
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        Text("Back")
                            .foregroundColor(.black)
                    }
                }
                .padding(.leading)
                
                Spacer()
                
                Text("Tulsa, OK")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                
                Spacer().frame(width: 24) // Space for alignment
            }
            .padding(.top, 8)
            
            // Movie Details
            HStack(alignment: .top) {
               
                    KFImage(URL(string: "\(movieInfo.imageURL)"))
                        .resizable()
                        .frame(width: 60, height: 90)
                        .cornerRadius(5)
                        .padding(.leading)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(movieInfo.title)")
                            .font(.system(size: 20, weight: .bold))
                        
                        Text("NR • \(movieInfo.runTime)")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                
                Spacer()
            }
            .padding(.vertical)
            
            // Date Selection
            VStack(alignment: .leading, spacing: 16) {
                Text("Choose Date")
                    .font(.system(size: 18, weight: .semibold))
                
                if let dates = viewModel.movieDetail?.movieInfo?.dateList {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(dates, id: \.self) { date in
                                let monthAndDay = viewModel.monthAndDay(from: date)
                                let formattedDate = viewModel.formattedDate(from: date)
                                
                                DateView(dayOfWeek: formattedDate, monthAndDay: monthAndDay, isSelected: date == viewModel.selectedDate)
                                    .onTapGesture {
                                        viewModel.selectedDate = date
                                    }
                                    .padding(.top,6)
                                    .padding(.bottom,6)
                            }
                        }
//                        .padding()
                        .background(.gray.opacity(0.2))
                    }
                }
              
                // Time Selection
                VStack(alignment: .leading, spacing: 16) {
                    Text("Choose Time")
                        .font(.system(size: 18, weight: .semibold))
                    GeometryReader { geometry in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.availableTimes, id: \.self) { time in
                                    TimeView(time: time)
                                        .frame(width: (geometry.size.width - 16) / 3, height: 100)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 24)
            
            Spacer()
            
            // Continue Button
            Button(action: {
                // Action for Continue button
            }) {
                Text("Continue")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
        } else {
            VStack {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
                    .padding(.top,50)
                    .font(.system(size: 8))
            }
            Spacer()
        }
    }
}
