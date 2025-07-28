import SwiftUI
import Observation

final class SettingsViewModel: ObservableObject {
    enum AppLanguage: String, CaseIterable, Identifiable {
        case english = "en"
        case russian = "ru"

        var id: String { rawValue }

        var label: String {
            switch self {
            case .english: return "English"
            case .russian: return "Русский"
            }
        }
    }

    enum AppTheme: String, CaseIterable, Identifiable {
        case system = "System"
        case light = "Light"
        case dark = "Dark"

        var id: String { rawValue }
    }

    @Published var selectedLanguage: AppLanguage = .russian
    @Published var selectedTheme: AppTheme = .system

    func resetAllData() {
        selectedLanguage = .russian
        selectedTheme = .system
        // TODO: Очистка SwiftData здесь
    }
}
