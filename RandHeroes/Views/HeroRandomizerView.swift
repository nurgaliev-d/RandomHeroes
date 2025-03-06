//
//  HeroRandomizerView.swift
//  RandHeroes
//
//  Created by Диас Нургалиев on 06.03.2025.
//

import SwiftUI

struct HeroRandomizerView: View {
    @State private var hero: Superhero?
    @State private var isLoading = false
    @StateObject private var favoritesManager = FavoritesManager()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        if let hero = hero {
                            AsyncImage(url: URL(string: hero.images.lg)) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 300, maxHeight: 250)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 100, height: 100)
                            }
                            
                            Text(hero.name)
                                .font(.largeTitle)
                                .bold()
                                .multilineTextAlignment(.center)
                            
                            Text(hero.biography.fullName)
                                .font(.title2)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HeroStatView(title: "Intelligence", value: hero.powerstats.intelligence)
                                HeroStatView(title: "Strength", value: hero.powerstats.strength)
                                HeroStatView(title: "Speed", value: hero.powerstats.speed)
                                HeroStatView(title: "Durability", value: hero.powerstats.durability)
                                HeroStatView(title: "Power", value: hero.powerstats.power)
                                HeroStatView(title: "Combat", value: hero.powerstats.combat)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        } else {
                            Text("Tap the button to load a superhero!")
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.horizontal)
                }
                
                VStack(spacing: 12) {
                    Button(action: loadHero) {
                        Text("Get Random Hero")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    if let hero = hero {
                        Button(action: {
                            toggleFavorite(hero)
                        }) {
                            Text(favoritesManager.isFavorite(hero) ? "Remove from Favorites" : "Add to Favorites")
                                .font(.title2)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(favoritesManager.isFavorite(hero) ? Color.red : Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    NavigationLink(destination: FavoritesView(favoritesManager: favoritesManager)) {
                        Text("View Favorites")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
            .navigationTitle("Random Hero")
        }
    }
    
    func loadHero() {
        isLoading = true
        HeroAPI.shared.fetchRandomHero { hero in
            DispatchQueue.main.async {
                self.hero = hero
                self.isLoading = false
            }
        }
    }

    func toggleFavorite(_ hero: Superhero) {
        if favoritesManager.isFavorite(hero) {
            favoritesManager.removeFavorite(hero)
        } else {
            favoritesManager.saveFavorite(hero)
        }
    }
}

struct HeroStatView: View {
    let title: String
    let value: Int?
    
    var body: some View {
        HStack {
            Text("\(title):")
                .fontWeight(.bold)
            Spacer()
            Text("\(value ?? 0)")
        }
        .padding(.vertical, 4)
    }
}
