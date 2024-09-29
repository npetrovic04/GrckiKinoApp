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
                    Text("Vreme izvlačenja: \(kolo.drawTime)")
                }
            }
            .navigationTitle("Grčki Kino - Kola")
            .onAppear {
                viewModel.fetchUpcomingGames()
            }
        }
    }
}

#Preview {
    ContentView()
}
