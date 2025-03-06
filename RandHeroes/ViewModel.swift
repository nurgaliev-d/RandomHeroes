//
//  ViewModel.swift
//  RandHeroes
//
//  Created by Диас Нургалиев on 06.03.2025.
//

import Foundation

struct Superhero: Codable, Identifiable {
    let id: Int
    let name: String
    let images: Images
    let biography: Biography
    let powerstats: PowerStats
}


struct Images: Codable {
    let lg: String
}

struct Biography: Codable {
    let fullName: String
    let publisher: String?
}

struct PowerStats: Codable {
    let intelligence, strength, speed, durability, power, combat: Int?
}

class HeroAPI {
    static let shared = HeroAPI()
    private let url = URL(string: "https://akabab.github.io/superhero-api/api/all.json")!

    func fetchRandomHero(completion: @escaping (Superhero?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let heroes = try JSONDecoder().decode([Superhero].self, from: data)
                completion(heroes.randomElement())
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
