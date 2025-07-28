import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var reloadTrigger: AppReloadTrigger
    
    var body: some View {
        NavigationStack {
            Form {
                Section("select_color_theme_title") {
                    Picker("color theme", selection: $settingsViewModel.selectedTheme) {
                        ForEach(SettingsViewModel.AppTheme.allCases) { theme in
                            Text(LocalizedStringKey(theme.rawValue)).tag(theme)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("select_language_title") {
                    Picker("Language", selection: $settingsViewModel.selectedLanguage) {
                        ForEach(SettingsViewModel.AppLanguage.allCases) { lang in
                            Text(LocalizedStringKey(lang.label)) .tag(lang)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle(Text("settings_tab"))
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
}
