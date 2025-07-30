//
//  AiColorPickerApp.swift
//  AiColorPicker
//
//  Created by A4reK0v on 28.07.2025.
//

import SwiftUI

class AppReloadTrigger: ObservableObject {
    @Published var reloadID = UUID()
    
    func reload() {
        reloadID = UUID()
    }
}

@main
struct AiColorPickerApp: App {
    
    @StateObject private var appStateViewModel = AppStateViewModel()
    @StateObject private var viewModel = SettingsViewModel()
    @StateObject private var reloadTrigger = AppReloadTrigger()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(viewModel)
                .environmentObject(reloadTrigger)
                .environmentObject(appStateViewModel)
        }
    }
}

struct RootView: View {
    
    @EnvironmentObject var appStateViewModel: AppStateViewModel
    @EnvironmentObject var viewModel: SettingsViewModel
    @EnvironmentObject var reloadTrigger: AppReloadTrigger
    
    var body: some View {
        GeometryReader { geo in
            MainTabView(size: geo.size)
                .id(reloadTrigger.reloadID)
                .environmentObject(viewModel)
                .environmentObject(reloadTrigger)
                .environment(\.locale, Locale(identifier: viewModel.selectedLanguage.id))
                .onChange(of: viewModel.selectedLanguage) { _, value in
                    UserDefaults.standard.set(value.id, forKey: "selected_language")
                    appStateViewModel.selectedTab = 2
                    reloadTrigger.reload() // 💥 Перезапуск интерфейса
                }
        }
    }
}
