//
//  DateView.swift
//  Cinergy
//
//  Created by Jinu on 26/08/2024.
//

import SwiftUI


struct DateView: View {
    var dayOfWeek: String
    var monthAndDay: String
    var isSelected: Bool
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor( Color(hex: "#A2C658"))
//                .frame(width: 60, height: 40)
//                .background(isSelected ? Color(hex: "#A2C658").opacity(0.2) : Color.clear)
//                .cornerRadius(2)
//                .multilineTextAlignment(.center)
                Text(monthAndDay)

        }
        .padding(5) // Padding around the VStack
        .background(isSelected ? Color(hex: "#A2C658").opacity(0.2) : Color.clear)
        .cornerRadius(8) // Rounded corners for the container box
    }
    
}

