import SwiftUI
import Observation

final class SettingsViewModel: ObservableObject {
    enum AppLanguage: String, CaseIterable, Identifiable {
        case english = "en"
        case russian = "ru"

        var id: String { rawValue }

        var label: String {
            switch self {
            case .english: return "english_lang"
            case .russian: return "russian_lang"
            }
        }
    }

    enum AppTheme: String, CaseIterable, Identifiable {
        case system = "system_theme"
        case light = "light_theme"
        case dark = "dark_theme"

        var id: String { rawValue }
    }
    
    init() {
        let savedLang = UserDefaults.standard.string(forKey: "selected_language") ?? "ru"
        self.selectedLanguage = AppLanguage(rawValue: savedLang) ?? .russian
    }

    @Published var selectedLanguage: AppLanguage = .russian
    @Published var selectedTheme: AppTheme = .system

    func resetAllData() {
        selectedLanguage = .russian
        selectedTheme = .system
        // TODO: Очистка SwiftData здесь
    }
}
