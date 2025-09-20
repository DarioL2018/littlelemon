//
//  Home.swift
//  Restaurant
//
//  Created by Dario Larenas on 13/9/25.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    @State private var selectedTab: Int! = 0
    
    var body: some View {
        VStack(spacing: 0) {
            
            TabView(selection: $selectedTab) {
                Menu(selectedTab: $selectedTab)
                    .font(.title)
                    .tabItem({
                        Label("Menu", systemImage: "list.dash")
                    })
                    .environment(\.managedObjectContext, persistence.container.viewContext)
                    .tag(0)
                //.frame(maxHeight: 200)
                
                UserProfile(selectedTab: $selectedTab)
                    .font(.title)
                    .tabItem({
                        Label("Profile", systemImage: "square.and.pencil")
                    })
                    .tag(1)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    Home()
}
