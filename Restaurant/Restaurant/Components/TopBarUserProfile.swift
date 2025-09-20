//
//  TopBarUserProfile.swift
//  Restaurant
//
//  Created by Dario Larenas on 19/9/25.
//

import SwiftUI

struct TopBarUserProfile: View {
    @Binding var selectedTab: Int!
    var body: some View {
        HStack{
            Button(action: {
                            selectedTab = 0
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .bold))
                                .padding()
                                .background(Circle().fill(Color(red: 0.286, green: 0.369, blue: 0.341) /*charcoal*/))
                        }
                        //.padding(.top, 16)
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
    TopBarUserProfile(selectedTab: .constant(0))
}
