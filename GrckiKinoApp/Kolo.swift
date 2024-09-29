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
}
