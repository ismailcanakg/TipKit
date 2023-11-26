//
//  ContentView.swift
//  TipKitProject
//
//  Created by İsmail Can Akgün on 25.11.2023.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    @State private var colors = MockData.colors
    let addColorTip = AddColorTip()
    let setFavorites = SetFavorites()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TipView(setFavorites)
                    .tipBackground(.teal.opacity(0.2))
                ForEach(colors, id: \.self) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill($0.gradient)
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .contextMenu {
                            Button("Favorite", systemImage: "star") {
                               // code to set as favorte
                                Task { await SetFavorites.setFavoriteEvent.donate() }
                            }
                        }
                }
            }
            .onAppear {
                Task { await SetFavorites.colorViewVisitedEvent.donate() }
            }
            .padding()
            .navigationTitle("Colors")
            .toolbar {
                Button {
                    colors.insert(.random, at: 0)
                    addColorTip.invalidate(reason: .actionPerformed)
                } label: {
                    Image(systemName: "plus")
                }
                // Açılır pencere ekleme
                .popoverTip(addColorTip)
            }
        }
    }
}

#Preview {
    ContentView()
        .task {
            try? Tips.resetDatastore() // Veri deposu resetleme
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)])
        }
}

extension Color {
    static var random: Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}

struct MockData {
    static let colors = [Color.random,
                         Color.random,
                         Color.random,
                         Color.random,]
}
