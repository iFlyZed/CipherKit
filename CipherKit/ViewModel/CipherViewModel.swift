//
//  CipherViewModel.swift
//  CipherKit
//
//  Created by Кирилл Зайцев on 24.02.2026.
//

import SwiftUI
import Combine

class CipherViewModel: ObservableObject {
    init() {
        if let data = UserDefaults.standard.data(forKey: "history"),
           let saved = try? JSONDecoder().decode([HistoryItem].self, from: data) {
            _history = Published(initialValue: saved)
            print("Загружено записей: \(saved.count)")
        } else {
            print("История не найдена")
        }
    }
    
    @Published var inputText: String = ""
    @Published var outputText: String = ""
    @Published var key: String = ""
    @Published var shiftValue: Int = 3
    @Published var selectedCipher: Int = 0
    @Published var history: [HistoryItem] = []
    
    func encrypt() {
        if selectedCipher == 0 {
            let caesar = CaesarCipher(shift: shiftValue)
            outputText = caesar.encrypt(text: inputText)
        } else {
            let vigenere = VigenereCipher(key: key)
            outputText = vigenere.encrypt(text: inputText)
        }
        addToHistory(isEncrypt: true)
    }
    
    func dencrypt() {
        if selectedCipher == 0 {
            let caesar = CaesarCipher(shift: shiftValue)
            outputText = caesar.dencrypt(text: inputText)
        } else {
            let vigenere = VigenereCipher(key: key)
            outputText = vigenere.dencrypt(text: inputText)
        }
        addToHistory(isEncrypt: false)
    }
    
    func addToHistory(isEncrypt: Bool) {
        let item = HistoryItem(
            id: UUID(),
            inputText: inputText,
            outputText: outputText,
            cipherType: selectedCipher == 0 ? "Цезарь" : "Виженер",
            key: selectedCipher == 0 ? "\(shiftValue)" : key,
            date: Date(),
            isEncrypt: isEncrypt
        )
        history.insert(item, at: 0)
        saveHistory()
    }
    
    func saveHistory() {
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: "history")
        }
    }
    
    func deleteHistoryItem(at offsets: IndexSet) {
        history.remove(atOffsets: offsets)
        saveHistory()
    }
}
