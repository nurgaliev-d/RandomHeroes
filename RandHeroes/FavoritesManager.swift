//
//  FavoritesManager.swift
//  RandHeroes
//
//  Created by Диас Нургалиев on 06.03.2025.
//

import Foundation

class FavoritesManager: ObservableObject {
    @Published var favorites: [Superhero] = []
    
    private let favoritesKey = "favoriteHeroes"

    init() {
        loadFavorites()
    }
    
    func saveFavorite(_ hero: Superhero) {
        if !favorites.contains(where: { $0.id == hero.id }) {
            favorites.append(hero)
            saveToUserDefaults()
        }
    }
    
    func removeFavorite(_ hero: Superhero) {
        favorites.removeAll { $0.id == hero.id }
        saveToUserDefaults()
    }
    
    func isFavorite(_ hero: Superhero) -> Bool {
        return favorites.contains(where: { $0.id == hero.id })
    }
    
    private func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
    
    private func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode([Superhero].self, from: savedData) {
            favorites = decoded
        }
    }
}
