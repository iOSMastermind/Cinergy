//
//  TimeView.swift
//  Cinergy
//
//  Created by Jinu on 26/08/2024.
//

import SwiftUI

struct TimeView: View {
    var time: String
    
    var body: some View {
        VStack{
            Text(time)
                .font(.system(size: 16, weight: .semibold))
//                .foregroundColor( Color(hex: "#A2C658"))
                .frame(width: 100, height: 45)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke( Color(hex: "#A2C658"), lineWidth: 2)
                )
        }
    }
}
