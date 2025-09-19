//
//  Onboarding.swift
//  Restaurant
//
//  Created by Dario Larenas on 13/9/25.
//

import SwiftUI

let kFirstName = "kFirstName"
let kLastName = "kLastName"
let kEmail = "kEmail"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                TopBarApp()
                
                HStack{
                    Spacer()
                    Text("Let's get to know you")
                        .foregroundStyle(.white)
                        .font(.system(size: 35, weight: .semibold))
                    Spacer()
                }
                .frame(height: 158)
                .background(Color(red: 0.286, green: 0.369, blue: 0.341))
                
                VStack(spacing: 20) {
                    Text("PERSONAL INFORMATION")
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 20)
                    
                    Text("First Name")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, -10)
                    TextField("First Name", text: $firstName)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    Text("Last Name")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 30)
                        .padding(.bottom, -10)
                    TextField("Last Name", text: $lastName)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        
                    
                    Text("Email")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 30)
                        .padding(.bottom, -10)
                    TextField("Email", text: $email)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    Button(action: {
                                if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                                    UserDefaults.standard.set(lastName, forKey: kLastName)
                                    UserDefaults.standard.set(email, forKey: kEmail)
                                    isLoggedIn = true
                                    UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                                }
                            }
                    ) {
                        Text("Register")
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                        NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                            EmptyView()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 52)
                    .background(Color.yellow)
                    .cornerRadius(8)
                    .padding(.top, 20)
                    Spacer()
                }
                .padding(20)
                
                
            }
            //.padding(30)
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
