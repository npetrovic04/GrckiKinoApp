//
//  TalonView.swift
//  GrckiKinoApp
//
//  Created by Nenad Petrovic on 01.10.2024.
//

import SwiftUI

struct TalonView: View {
    
    // Obeležavanje izabranih brojeva
        @State private var selectedNumbers: Set<Int> = []  // Set za čuvanje izabranih brojeva
        let maxSelection = 15  // Maksimalan broj brojeva koji mogu biti izabrani
        let koloId: Int  // Kolo ID koji ćemo prikazati
        let drawTime: String  // Vreme izvlačenja
    
    var body: some View {
        VStack {
            
            // Gornji deo sa informacijama o vremenu i broju kola
                        HStack {
                            Text("Vreme izvlačenja: \(drawTime) | Kolo: \(koloId)")
                                .font(.headline)
                                .padding()
                        }
                        .background(Color.gray.opacity(0.2))  // Siva pozadina za gornji deo
                        .padding(.bottom)
            
            // Grid prikaz 80 brojeva
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 10), spacing: 10) {
                ForEach(1...80, id: \.self) { number in
                    Button(action: {
                        selectNumber(number)
                    }) {
                        Text("\(number)")
                            .frame(width: 40, height: 40)
                            .background(selectedNumbers.contains(number) ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    // Onemogućiti izbor više brojeva ako je maksimum postignut
                                        .disabled(selectedNumbers.count >= maxSelection && !selectedNumbers.contains(number))
                                    }
                                }
                                .padding()
            
            // Prikaz broja izabranih kuglica i dugme za slučajni odabir
                        HStack {
                            Button(action: randomSelect) {
                                Text("Slučajni odabir")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            Spacer()
                            Text("Brojeva: \(selectedNumbers.count)")
                                .padding()
                        }
                        .padding(.horizontal)

                        Spacer()  // Dodaj prostor na kraju ekrana
                    }
                    .padding()
                }
    
    // Logika za izbor brojeva
        private func selectNumber(_ number: Int) {
            if selectedNumbers.contains(number) {
                selectedNumbers.remove(number)  // Ukloni broj ako je već izabran
            } else if selectedNumbers.count < maxSelection {
                selectedNumbers.insert(number)  // Dodaj broj ako nije izabran i ako ima mesta
            }
        }
    
    // Nasumični odabir brojeva
        private func randomSelect() {
            selectedNumbers.removeAll()  // Praznimo trenutni izbor
            while selectedNumbers.count < maxSelection {
                let randomNumber = Int.random(in: 1...80)
                selectedNumbers.insert(randomNumber)  // Dodaj nasumičan broj dok ne dođemo do 8 izabranih
            }
        }
    }


struct TalonView_Previews: PreviewProvider {
    static var previews: some View {
        TalonView(koloId: 838393, drawTime: "15:15")
    }
}



#Preview {
    TalonView(koloId: 838393, drawTime: "15:15")
}
