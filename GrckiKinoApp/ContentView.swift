//
//  ContentView.swift
//  GrckiKinoApp
//
//  Created by Nenad Petrovic on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = KinoViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.upcomingGames) { kolo in
                VStack(alignment: .leading) {
                    Text("Kolo ID: \(kolo.id)")
                    Text("Vreme izvlačenja: \(formattedDate(kolo.drawTime))")
                    
                    
                    // Prikaz tajmera
                    if let timeRemaining = viewModel.countdowns[kolo.id], timeRemaining > 0 {
                        Text("Preostalo vreme: \(formattedTime(timeRemaining))")
                    } else {
                        Text("Izvlacenje je zavrseno")
                    }
                }
                // Dodaj onAppear ovde za svako kolo
                .onAppear {
                    print("Starting timer for Kolo \(kolo.id)")
                    viewModel.startTimer(for: kolo)
                }
            }
            .navigationTitle("Grčki Kino - Kola")
            .onAppear {
                viewModel.fetchUpcomingGames()
            }
        }
    }
    
    // Pomoćna funkcija za formatiranje vremena izvlačenja
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
    
    // Pomoćna funkcija za formatiranje preostalog vremena (sekunde)
    func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    ContentView()
}
