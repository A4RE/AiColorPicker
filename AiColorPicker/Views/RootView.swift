import SwiftUI

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
