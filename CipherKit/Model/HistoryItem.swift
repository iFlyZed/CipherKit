//
//  HistoryItem.swift
//  CipherKit
//
//  Created by Кирилл Зайцев on 24.02.2026.
//

import Foundation

struct HistoryItem: Identifiable, Codable {
    let id: UUID
    let inputText: String
    let outputText: String
    let cipherType: String
    let key: String
    let date: Date
    let isEncrypt: Bool
}
