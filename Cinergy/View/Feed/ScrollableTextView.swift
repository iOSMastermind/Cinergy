//
//  ScrollableTextView.swift
//  Cinergy
//
//  Created by Jinu on 25/08/2024.
//

import SwiftUI

struct ScrollableTextView: View {
    var text: String
    
    var body: some View {
        ScrollView {
            Text(text)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading) // Adjusts the alignment and width
        }
    }
}


