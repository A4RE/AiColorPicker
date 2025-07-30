import SwiftUI

// TODO: Add support button (learn how to send messages from app to mail)
struct SettingsView: View {
    
    let size: CGSize
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var reloadTrigger: AppReloadTrigger
    
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    
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
                            Text(LocalizedStringKey(lang.label)).tag(lang)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Version: \(appVersion)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        Text("Created by Andrei Kovalenko")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, size.height * 0.005)
                }
            }
            .navigationTitle(Text("settings_tab"))
        }
    }
}

#Preview {
    GeometryReader { geo in
        SettingsView(size: geo.size)
            .environmentObject(SettingsViewModel())
    }
}
