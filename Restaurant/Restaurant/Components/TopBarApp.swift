//
//  TabBarApp.swift
//  Restaurant
//
//  Created by Dario Larenas on 16/9/25.
//

import SwiftUI

struct TopBarApp: View {
    var body: some View {
        HStack{
            Spacer()
            Image("logo")
                .frame(width: 179, height: 56)
            Spacer()
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
                .padding(.horizontal)
                .background(Color.white)
    }
}

#Preview {
    TopBarApp()
}
