//
//  KinoViewModel.swift
//  GrckiKinoApp
//
//  Created by Nenad Petrovic on 28.09.2024.
//

import Foundation
import Combine

class KinoViewModel: ObservableObject {
    
    @Published var upcomingGames: [Kolo] = []
    private var cancellable: AnyCancellable?

    func fetchUpcomingGames() {
        guard let url = URL(string: "https://api.opap.gr/draws/v3.0/1100/upcoming/20") else {
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Kolo].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.upcomingGames, on: self)
    }
}

