//
//  FavoritesView.swift
//  RandHeroes
//
//  Created by Диас Нургалиев on 06.03.2025.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesManager: FavoritesManager

    var body: some View {
        List {
            ForEach(favoritesManager.favorites) { hero in
                HStack {
                    AsyncImage(url: URL(string: hero.images.lg)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ProgressView()
                    }

                    Text(hero.name)
                        .font(.headline)
                        .padding(.leading, 10)

                    Spacer()

                    Button(action: {
                        favoritesManager.removeFavorite(hero)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle("Favorites")
    }
}
