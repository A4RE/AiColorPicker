import SwiftUI

struct MainTabView: View {
    
    let size: CGSize
    @EnvironmentObject var settingViewModel: SettingsViewModel
    @EnvironmentObject var appStateViewModel: AppStateViewModel
    
    var body: some View {
        TabView(selection: $appStateViewModel.selectedTab) {
            HomeView(size: size)
                .tabItem {
                    Label("home_tab", systemImage: "house")
                }
                .tag(0)
            HistoryView()
                .tabItem {
                    Label("history_tab", systemImage: "list.clipboard")
                }
                .tag(1)
            SettingsView()
                .tabItem {
                    Label("settings_tab", systemImage: "gearshape")
                }
                .tag(2)
        }
        .environmentObject(settingViewModel)
    }
}
