//
//  HistoryView.swift
//  CipherKit
//
//  Created by Кирилл Зайцев on 24.02.2026.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: CipherViewModel
    @State private var selectedItem: HistoryItem?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.history) { item in
                    Button {
                        selectedItem = item
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(item.cipherType)
                                    .font(.headline)
                                Text(item.isEncrypt ? "Шифрование" : "Дешифрование")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Text("\(item.inputText) → \(item.outputText)")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteHistoryItem)
            }
            .listStyle(.plain)
            .sheet(item: $selectedItem) { item in
                HistoryDetailView(item: item)
            }
            .navigationTitle("История")
            .toolbar {
                if !viewModel.history.isEmpty {
                    Button("Очистить") {
                        viewModel.history.removeAll()
                        viewModel.saveHistory()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    HistoryView(viewModel: CipherViewModel())
}
