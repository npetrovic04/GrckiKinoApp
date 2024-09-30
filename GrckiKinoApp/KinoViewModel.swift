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
    @Published var countdowns: [Int: TimeInterval] = [:] // Čuva preostalo vreme za svako kolo
    private var cancellables = Set<AnyCancellable>() // Koristimo set da čuvamo sve cancellable objekte

    func fetchUpcomingGames() {
        guard let url = URL(string: "https://api.opap.gr/draws/v3.0/1100/upcoming/20") else {
            return
        }

        // Sada mrežni poziv dodajemo u set cancellables, umesto u jednu varijablu cancellable
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Kolo].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] games in
                self?.upcomingGames = games
            })
            .store(in: &cancellables) // Čuvamo cancellable u setu
    }

    func startTimer(for kolo: Kolo) {
        print("Starting timer for Kolo \(kolo.id)")
        
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        timer
            .map { _ in
                let currentTime = Date()  // Trenutno vreme
                return kolo.drawTime.timeIntervalSince(currentTime)  // Računamo preostalo vreme
            }
            .sink { [weak self] timeRemaining in
                print("Time remaining for Kolo \(kolo.id): \(timeRemaining) seconds")
                
                if timeRemaining > 0 {
                    self?.countdowns[kolo.id] = timeRemaining
                } else {
                    self?.countdowns[kolo.id] = 0
                }
            }
            .store(in: &cancellables)
    }


}


