//
//  UserProfile.swift
//  Restaurant
//
//  Created by Dario Larenas on 13/9/25.
//

import SwiftUI

struct UserProfile: View {
        
    @State var firstName: String = UserDefaults.standard.string(forKey: "kFirstName") ?? ""
    @State var lastName: String = UserDefaults.standard.string(forKey: "kLastName") ?? ""
    @State var email: String = UserDefaults.standard.string(forKey: "kEmail") ?? ""
    @State var phone: String = UserDefaults.standard.string(forKey: "kPhone") ?? ""
    @State var selectedChange = false
    @State var selectedRemove = false
    
    @State var isOrdersStatuses = UserDefaults.standard.bool(forKey: "kOrdersStatuses")
    @State var isPasswordChanges = UserDefaults.standard.bool(forKey: "kPasswordChanges")
    @State var isSpecialOffers = UserDefaults.standard.bool(forKey: "kSpecialOffers")
    @State var isNewsletter = UserDefaults.standard.bool(forKey: "kNewsletter")
    @Binding var selectedTab: Int!
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            TopBarUserProfile(selectedTab: $selectedTab)
                .padding(.bottom, 10)
            Text("Personal information")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                
                Image("profile-image-placeholder")
                    .resizable()
                    .frame(width: 66, height: 66)
                Button(action: {
                    //selectedChange.toggle()
                }) {
                    Text("Change")
                        .font(.system(size: 16, weight: .medium))
                        //.foregroundColor(selectedChange ? Color.white : Color(red: 0.286, green: 0.369, blue: 0.341))
                        .foregroundColor(Color.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                //.fill(selectedChange ? Color(red: 0.286, green: 0.369, blue: 0.341) /*charcoal*/ : Color.white)
                                .fill(Color(red: 0.286, green: 0.369, blue: 0.341) /*charcoal*/)
                                .stroke(Color(red: 0.286, green: 0.369, blue: 0.341), lineWidth: 1)
                        )
                }
                .padding(.leading, 12)
                Button(action: {
                    selectedRemove.toggle()
                }) {
                    Text("Remove")
                        .font(.system(size: 16, weight: .medium))
                        //.foregroundColor(selectedRemove ? Color.white : Color(red: 0.286, green: 0.369, blue: 0.341))
                        .foregroundColor(Color(red: 0.286, green: 0.369, blue: 0.341))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                //.fill(selectedRemove ? Color(red: 0.286, green: 0.369, blue: 0.341) /*charcoal*/ : Color.white)
                                .fill(Color.white)
                                .stroke(Color(red: 0.286, green: 0.369, blue: 0.341), lineWidth: 1)
                        )
                }.padding(.leading, 12)
                Spacer()
            }
            
            VStack(spacing: 15) {
                Text("First Name")
                    .font(.system(size: 12, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, -10)
                
                TextField("First Name", text: $firstName)
                    .font(.system(size: 15))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                Text("Last Name")
                    .font(.system(size: 12, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, -10)
                
                TextField("Last Name", text: $lastName)
                    .font(.system(size: 15))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                Text("Email")
                    .font(.system(size: 12, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, -10)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .font(.system(size: 15))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                Text("Phone Number")
                    .font(.system(size: 12, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, -10)
                
                TextField("Phone Number", text: $phone)
                    .keyboardType(.phonePad)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .font(.system(size: 15))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                Text("Email notifications")
                    .font(.system(size: 15, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                CustomCheckBox(isChecked: $isOrdersStatuses, label: "Order statuses")
                    .frame(maxWidth: .infinity, alignment: .leading)
                CustomCheckBox(isChecked: $isPasswordChanges, label: "Password changes")
                    .frame(maxWidth: .infinity, alignment: .leading)
                CustomCheckBox(isChecked: $isSpecialOffers, label: "Special offers")
                    .frame(maxWidth: .infinity, alignment: .leading)
                CustomCheckBox(isChecked: $isNewsletter, label: "Newsletter")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Button(action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                lougout()
                presentation.wrappedValue.dismiss()
            }
                ) {
                Text("Log out")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
            }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 40)
                .background(Color.yellow)
                .cornerRadius(8)
                .padding(.top, 20)
                .padding(.bottom, 20)
            HStack{
                Button(action: {
                    discardChanges()
                }) {
                    Text("Discard changes")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(selectedChange ? Color.white : Color(red: 0.286, green: 0.369, blue: 0.341))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(selectedChange ? Color(red: 0.286, green: 0.369, blue: 0.341) /*charcoal*/ : Color.white)
                                .stroke(Color(red: 0.286, green: 0.369, blue: 0.341), lineWidth: 1)
                        )
                }
                .padding(.leading, 12)
                
                Button(action: {
                    saveChanges()
                    
                }) {
                    Text("Save changes")
                        .font(.system(size: 16, weight: .medium))
                        //.foregroundColor(selectedChange ? Color.white : Color(red: 0.286, green: 0.369, blue: 0.341))
                        .foregroundColor(Color.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                //.fill(selectedChange ? Color(red: 0.286, green: 0.369, blue: 0.341) /*charcoal*/ : Color.white)
                                .fill(Color(red: 0.286, green: 0.369, blue: 0.341) /*charcoal*/)
                                .stroke(Color(red: 0.286, green: 0.369, blue: 0.341), lineWidth: 1)
                        )
                }
                .padding(.leading, 12)
            }
            //Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    func saveChanges() {
        UserDefaults.standard.set(firstName, forKey: "kFirstName")
        UserDefaults.standard.set(lastName, forKey: "kLastName")
        UserDefaults.standard.set(email, forKey: "kEmail")
        UserDefaults.standard.set(phone, forKey: "kPhone")
        UserDefaults.standard.set(isOrdersStatuses, forKey: "kOrderStatuses")
        UserDefaults.standard.set(isPasswordChanges, forKey: "kPasswordChanges")
        UserDefaults.standard.set(isSpecialOffers, forKey: "kSpecialOffers")
        UserDefaults.standard.set(isNewsletter, forKey: "kNewsletter")
    }
    
    func discardChanges() {
        firstName = UserDefaults.standard.string(forKey: "kFirstName") ?? ""
        lastName = UserDefaults.standard.string(forKey: "kLastName") ?? ""
        email = UserDefaults.standard.string(forKey: "kEmail") ?? ""
        phone = UserDefaults.standard.string(forKey: "kPhone") ?? ""
        isOrdersStatuses = UserDefaults.standard.bool(forKey: "kOrdersStatuses")
        isPasswordChanges = UserDefaults.standard.bool(forKey: "kPasswordChanges")
        isSpecialOffers = UserDefaults.standard.bool(forKey: "kSpecialOffers")
        isNewsletter = UserDefaults.standard.bool(forKey: "kNewsletter")
    }
    
    func lougout() {
        UserDefaults.standard.set("", forKey: "kFirstName")
        UserDefaults.standard.set("", forKey: "kLastName")
        UserDefaults.standard.set("", forKey: "kEmail")
        UserDefaults.standard.set("", forKey: "kPhone")
        UserDefaults.standard.set(false, forKey: "kOrderStatuses")
        UserDefaults.standard.set(false, forKey: "kPasswordChanges")
        UserDefaults.standard.set(false, forKey: "kSpecialOffers")
        UserDefaults.standard.set(false, forKey: "kNewsletter")
    }
}



struct CustomCheckBox: View {
    @Binding var isChecked: Bool
    let label: String
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square" : "square")
                    .resizable()
                    .foregroundColor(isChecked ? Color.white : .black)
                    .background(isChecked ? Color(red: 0.286, green: 0.369, blue: 0.341) /*charcoal*/ : Color.clear)
                    .frame(width: 25, height: 25)
                Text(label)
                    .font(.system(size: 14))
                    
            }
        }
        .buttonStyle(PlainButtonStyle()) // evita animaciones de botón azul
    }
}


#Preview {
    UserProfile(selectedTab: .constant(0))
}
