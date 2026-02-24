//
//  HistoryDetailView.swift
//  CipherKit
//
//  Created by Кирилл Зайцев on 24.02.2026.
//

import SwiftUI

struct HistoryDetailView: View {
    let item: HistoryItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(item.isEncrypt ? "Шифрование" : "Дешифрование")
                .font(.largeTitle)
                .bold()
            
            Group {
                Text("Шифр: \(item.cipherType)")
                Text("Ключ: \(item.key)")
                Text("Исходный текст: \(item.inputText)")
                Text("Результат: \(item.outputText)")
                Text("Дата: \(item.date.formatted())")
            }
            .font(.body)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HistoryDetailView(item: HistoryItem(
        id: UUID(),
        inputText: "ПРИВЕТ",
        outputText: "ТУЛЕИХ",
        cipherType: "Цезарь",
        key: "3",
        date: Date(),
        isEncrypt: true
    ))
}
