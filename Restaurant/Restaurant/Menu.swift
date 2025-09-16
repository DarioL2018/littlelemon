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
    @State private var selectedCategory: String? = nil

    var body: some View {
        VStack{
            VStack {
                Text("Little Lemon")
                    .font(.system(size: 64, weight: .medium))
                    .foregroundColor(Color(red: 0.957, green: 0.808, blue: 0.078))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                
                HStack(alignment: VerticalAlignment.center){
                    
                    VStack{
                        Text("Chicago")
                            .font(.system(size: 40, weight: .medium))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                        
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .font(.system(size: 18, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                    }
                    Image("upperpanelimage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.top, 30)
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, -60)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                    
                    
                    TextField("Search menu", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 14))
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        .background(Color.white)
                    
                )
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                
                /*TextField("Search menu", text: $searchText)
                 .textFieldStyle(RoundedBorderTextFieldStyle())
                 .padding(.horizontal)
                 .padding(.bottom, 10)*/
            }
            
            .background(Color(red: 0.286, green: 0.369, blue: 0.341))
            
            Categories(categories: ["Starters", "Mains", "Desserts"],  selectedFilter: $selectedCategory)
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 10)
            
            FetchedObjects(
                predicate:buildPredicate(),
                sortDescriptors: buildSortDescriptors()
                
            ) {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes) {
                        dish in
                        HStack{
                            /*Text("\(dish.title ?? "") - $\(dish.price ?? "0.00")")
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
                            }*/
                            DishItem(
                                dish: MenuItem(
                                    title: dish.title ?? "",
                                    image: dish.image ?? "",
                                    price: dish.price ?? "",
                                    description: dish.descriptionItem ?? "",
                                    category: dish.category ?? ""
                                    ))
                                
                        }
                        .listRowSeparator(.hidden)
                        
                        
                    }
                }
                .listStyle(.plain)
                
            }
            
            //.frame(maxWidth: .infinity, alignment: .leading)
            //.padding(.horizontal, -20)
            
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
        let trimmedSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var predicates: [NSPredicate] = []
        
        if !trimmedSearch.isEmpty {
            predicates.append(NSPredicate(format: "title CONTAINS[cd] %@", trimmedSearch))
        }
        
        if let category = selectedCategory {
            predicates.append(NSPredicate(format: "category == [c] %@", category))
        }
        
        return predicates.isEmpty ? NSPredicate(value: true) : NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
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
                    dish.descriptionItem = menuElement.description
                    dish.category = menuElement.category
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
