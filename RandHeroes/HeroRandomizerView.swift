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

   var body: some View {
       VStack {
           if let hero = hero {
               VStack {
                   AsyncImage(url: URL(string: hero.images.lg)) { image in
                       image.resizable()
                           .scaledToFit()
                           .frame(height: 250)
                           .cornerRadius(15)
                   } placeholder: {
                       ProgressView()
                   }
                   Text(hero.name)
                       .font(.largeTitle)
                       .bold()

                   Text(hero.biography.fullName)
                       .font(.title2)
                       .foregroundColor(.gray)

                   VStack(alignment: .leading, spacing: 5) {
                       Text("Intelligence: \(hero.powerstats.intelligence ?? 0)")
                       Text("Strength: \(hero.powerstats.strength ?? 0)")
                       Text("Speed: \(hero.powerstats.speed ?? 0)")
                       Text("Durability: \(hero.powerstats.durability ?? 0)")
                       Text("Power: \(hero.powerstats.power ?? 0)")
                       Text("Combat: \(hero.powerstats.combat ?? 0)")
                   }
                   .padding()
               }
               .padding()
           } else {
               Text("Tap the button to load a superhero!")
                   .padding()
           }

           Button(action: loadHero) {
               Text("Get Random Hero")
                   .font(.title2)
                   .padding()
                   .frame(maxWidth: .infinity)
                   .background(Color.blue)
                   .foregroundColor(.white)
                   .cornerRadius(10)
           }
           .padding()
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
}
