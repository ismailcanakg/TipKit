//
//  TipKitProjectApp.swift
//  TipKitProject
//
//  Created by İsmail Can Akgün on 25.11.2023.
//

import SwiftUI
import TipKit

@main
struct TipKitProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
//                    try? Tips.resetDatastore()
                    try? Tips.configure([
//                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)])
                }
        }
    }
}
