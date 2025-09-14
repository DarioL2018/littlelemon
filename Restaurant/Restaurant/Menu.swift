//
//  Menu.swift
//  Restaurant
//
//  Created by Dario Larenas on 13/9/25.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            Text("Title")
                .font(.headline)
            Text("Location")
                .font(.caption)
            Text("Description")
                .font(.caption)
            TextField("Search menu", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
            FetchedObjects(
                predicate:buildPredicate(),
                sortDescriptors: buildSortDescriptors()
                
            ) {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes) {
                        dish in
                        HStack{
                            Text("\(dish.title ?? "") - $\(dish.price ?? "0.00")")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 120)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                        .frame(height: 120)
                                }
                        }
                        
                    }
                }
            }
            
        }
        .onAppear(){
            getMenuData()
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
                    NSSortDescriptor(
                        key: "title",
                        ascending: true,
                        selector: #selector(NSString.localizedStandardCompare(_:))
                    )
                ]
    }
    
    func buildPredicate() -> NSPredicate {
            if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return NSPredicate(value: true)
            } else {
                return NSPredicate(
                    format: "title CONTAINS[cd] %@",
                    searchText
                )
            }
        }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data,
               let responseString = String(data: data, encoding: .utf8){
                //print(responseString)
                let fullMenu = try? JSONDecoder().decode(MenuList.self, from: data)
                fullMenu?.menu.forEach{
                    menuElement in
                    let dish = Dish(context: self.viewContext)
                    dish.title = menuElement.title
                    dish.image = menuElement.image
                    dish.price = menuElement.price
                }
                try? self.viewContext.save()
            }
        }
        
        task.resume()
        
    }
}

#Preview {
    Menu()
}
