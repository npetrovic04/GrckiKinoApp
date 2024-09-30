//
//  TalonView.swift
//  GrckiKinoApp
//
//  Created by Nenad Petrovic on 01.10.2024.
//

import SwiftUI

struct TalonView: View {
    @State private var selectedNumbers: [Int] = []  // Čuva izabrane brojeve
    
    let numbers = Array(1...80)  // Brojevi od 1 do 80
    
    var body: some View {
        VStack {
            Text("Izaberi do 15 brojeva")
                .font(.headline)
                .padding()
            
            // Grid prikaz za brojeve
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 10) {
                ForEach(numbers, id: \.self) { number in
                    Button(action: {
                        selectNumber(number)
                    }) {
                        Text("\(number)")
                            .font(.title2)
                            .frame(width: 50, height: 50)
                            .background(selectedNumbers.contains(number) ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
            }
            
            // Prikaz broja izabranih kuglica i kvote
            Text("Izabrano: \(selectedNumbers.count)")
                .padding()
            
            Button("Potvrdi") {
                // Logika za potvrđivanje izbora
            }
            .disabled(selectedNumbers.isEmpty)
        }
        .padding()
    }
    
    // Funkcija za izbor broja
    func selectNumber(_ number: Int) {
        if selectedNumbers.contains(number) {
            // Ako je broj već izabran, ukloni ga iz liste
            selectedNumbers.removeAll { $0 == number }
        } else if selectedNumbers.count < 15 {
            // Dodaj broj ako je manje od 15 izabrano
            selectedNumbers.append(number)
        }
    }
}


#Preview {
    TalonView()
}
