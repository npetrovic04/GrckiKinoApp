//
//  TalonView.swift
//  GrckiKinoApp
//
//  Created by Nenad Petrovic on 01.10.2024.
//

import SwiftUI

struct TalonView: View {
    @State private var selectedNumbers: Set<Int> = []  // Čuvamo izabrane brojeve
    
    let maxSelection = 15  // Maksimalan broj izabranih brojeva
    
    var body: some View {
        VStack {
            Text("Izaberite do \(maxSelection) brojeva")
                .font(.headline)
                .padding()
            
            // Grid prikaz 80 brojeva
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                ForEach(1...80, id: \.self) { number in
                    Button(action: {
                        selectNumber(number)
                    }) {
                        Text("\(number)")
                            .frame(width: 50, height: 50)
                            .background(selectedNumbers.contains(number) ? Color.green : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    .disabled(selectedNumbers.count >= maxSelection && !selectedNumbers.contains(number))  // Onemogućavamo izbor više od 15 brojeva
                }
            }
            
            Text("Izabrano brojeva: \(selectedNumbers.count)")
                .padding()
            
            Spacer()
        }
        .padding()
    }
    
    private func selectNumber(_ number: Int) {
        if selectedNumbers.contains(number) {
            selectedNumbers.remove(number)  // Ako je broj već izabran, ukloni ga
        } else if selectedNumbers.count < maxSelection {
            selectedNumbers.insert(number)  // Dodaj broj ako nije već izabran i ako je ispod limita
        }
    }
}

//struct TalonView_Previews: PreviewProvider {
//    static var previews: some View {
//        TalonView()
//    }
//}



#Preview {
    TalonView()
}
