//
//  UserProfile.swift
//  Restaurant
//
//  Created by Dario Larenas on 13/9/25.
//

import SwiftUI

struct UserProfile: View {
    let firstName: String = UserDefaults.standard.string(forKey: "firstName") ?? ""
    let lastName: String = UserDefaults.standard.string(forKey: "lastName") ?? ""
    let email: String = UserDefaults.standard.string(forKey: "email") ?? ""
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal information")
                .font(.headline)
            Image("profile-image-placeholder")
            Text(firstName)
            Text(lastName)
            Text(email)
            Button(action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                presentation.wrappedValue.dismiss()
            }
                ) {
                Text("Logout")
            }
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
