//
//  ContentView.swift
//  CipherKit
//
//  Created by Кирилл Зайцев on 24.02.2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CipherViewModel()
    
    var body: some View {
        TabView {
            CipherView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "lock.fill")
                    Text("Шифр")
                }
            
            HistoryView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("История")
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
