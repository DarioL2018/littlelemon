//
//  TopBarHome.swift
//  Restaurant
//
//  Created by Dario Larenas on 15/9/25.
//

import SwiftUI

struct TopBarHome: View {
    var body: some View {
        HStack{
            Spacer()
            Image("logo")
                .frame(width: 179, height: 56)
            Spacer()
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 56, height: 56)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
                .padding(.horizontal)
                .background(Color.white)
        
    }
}

#Preview {
    TopBarHome()
}
