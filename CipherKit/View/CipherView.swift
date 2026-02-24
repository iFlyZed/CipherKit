//
//  CipherView.swift
//  CipherKit
//
//  Created by Кирилл Зайцев on 24.02.2026.
//

import SwiftUI

struct CipherView: View {
    @ObservedObject var viewModel: CipherViewModel
    
    var body: some View {
        VStack(spacing:16) {
            Text("CipherKit")
                .font(.largeTitle)
                .bold()
            Picker("Шифр", selection: $viewModel.selectedCipher) {
                Text("Цезарь").tag(0)
                Text("Виженер").tag(1)
                    
            }
            .pickerStyle(.segmented)
            
            TextField("Введите текст", text: $viewModel.inputText)
                .textFieldStyle(.roundedBorder)
                .onChange(of: viewModel.inputText) {
                    viewModel.inputText = viewModel.inputText.uppercased()
                }
            
            if viewModel.selectedCipher == 0 {
                Stepper("Сдвиг \(viewModel.shiftValue)", value: $viewModel.shiftValue, in: 1...31)
            } else {
                TextField("Ключ", text: $viewModel.key)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: viewModel.key) {
                            viewModel.key = viewModel.key.uppercased()
                        }
            }
            
            HStack(spacing: 16) {
                Button("Зашифровать") {
                    viewModel.encrypt()
                }
                .buttonStyle(.borderedProminent)

                Button("Расшифровать") {
                    viewModel.dencrypt()
                }
                .buttonStyle(.bordered)
            }
            
            Text(viewModel.outputText)
                .font(.title2)
                .bold()
            
            if !viewModel.outputText.isEmpty {
                Button("Скопировать") {
                    UIPasteboard.general.string = viewModel.outputText
                }
                .font(.caption)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    CipherView(viewModel: CipherViewModel())
}
