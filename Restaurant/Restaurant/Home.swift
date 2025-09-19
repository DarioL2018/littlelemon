//
//  Home.swift
//  Restaurant
//
//  Created by Dario Larenas on 13/9/25.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarHome()
            TabView {
                Menu()
                    .font(.title)
                    .tabItem({
                        Label("Menu", systemImage: "list.dash")
                    })
                    .environment(\.managedObjectContext, persistence.container.viewContext)
                //.frame(maxHeight: 200)
                
                UserProfile()
                    .font(.title)
                    .tabItem({
                        Label("Profile", systemImage: "square.and.pencil")
                    })
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    Home()
}
