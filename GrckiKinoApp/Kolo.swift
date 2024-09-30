//
//  Kolo.swift
//  GrckiKinoApp
//
//  Created by Nenad Petrovic on 28.09.2024.
//

import Foundation

struct Kolo: Identifiable, Codable {
    let id: Int
    let drawTime: Date
    let status: String
    let winningNumbers: [Int]?

    enum CodingKeys: String, CodingKey {
        case id = "drawId"
        case drawTime
        case status
        case winningNumbers
    }
    
    // Rukovanje vremenom - parsiranje Unix timestampa
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        let drawTimeRaw = try container.decode(Double.self, forKey: .drawTime)
        
        // Ovde ispiši vrednost drawTimeRaw
        print("Draw time (raw): \(drawTimeRaw)")
        
        // Ako je vreme u milisekundama, delimo sa 1000 da bi se dobile sekunde
        drawTime = Date(timeIntervalSince1970: drawTimeRaw / 1000.0)
        status = try container.decode(String.self, forKey: .status)
        winningNumbers = try? container.decode([Int].self, forKey: .winningNumbers)
    }

}
