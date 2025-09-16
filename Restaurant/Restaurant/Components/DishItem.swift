//
//  DishItem.swift
//  Restaurant
//
//  Created by Dario Larenas on 16/9/25.
//

import SwiftUI

struct DishItem: View {
    let dish: MenuItem
        // let navController: NavigationStack? // si usas navegación

        var body: some View {
            VStack(spacing: 0) {
                Button(action: {
                    // Navegación si la necesitas
                    // navController?.navigate(to: DishDetailsView(dishId: dish.id))
                }) {
                    HStack(alignment: .top, spacing: 12) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(dish.title)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)

                            Text(dish.description) // dish.description
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                .lineLimit(2)
                                .truncationMode(.tail)
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: .leading)
                                .padding(.vertical, 10)

                            Text(dish.price)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                        }

                       
                        AsyncImage(url: URL(string: dish.image)) { phase in
                                switch phase {
                                case .success(let img):
                                    img
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                default:
                                    Color.gray.opacity(0.2)
                                }
                            }
                            .frame(width: 83, height: 83)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                       
                    }
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(0)
                }

                Divider()
                    .padding(.horizontal, 8)
                    .background(Color(red: 237/255, green: 239/255, blue: 238/255)) // EDEFEE
            }
            .background(Color(red: 237/255, green: 239/255, blue: 238/255)) // EDEFEE
        }
}


private let exampleDish = MenuItem(
    title: "Example",
    image: "https://via.placeholder.com/150",
    price: "10",
    description: "test",
    category: "salad"
)

#Preview {
    DishItem(dish: exampleDish)
}
