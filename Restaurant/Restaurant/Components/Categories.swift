//
//  Categories.swift
//  Restaurant
//
//  Created by Dario Larenas on 16/9/25.
//

import SwiftUI

struct Categories: View {
    let categories: [String]
    //let onGroupUpdate: (String) -> Void
    @Binding var selectedFilter: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("ORDER FOR DELIVERY!")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
                //.padding(.leading, 8)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(categories, id: \.self) { text in
                        Button(action: {
                            selectedFilter = (selectedFilter == text) ? nil : text
                        }) {
                            Text(text.capitalized)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color(red: 0.286, green: 0.369, blue: 0.341))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(selectedFilter == text ? Color(red: 0.2, green: 0.2, blue: 0.2) /*charcoal*/ : Color(red: 0.929, green: 0.937, blue: 0.933)/*cloud*/)
                                )
                        }
                        //.padding(8)
                    }
                }
                //.padding(.horizontal)
            }
        }
    }
}

/*#Preview {
    Categories(categories: ["VEGETEBLES", "FRUITS"])
}*/
