import SwiftUI

@main
struct AiColorPickerApp: App {
    
    init() {
        AppDelegate.orientationLock = .portrait
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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

class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication,
                     supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}

class AppReloadTrigger: ObservableObject {
    @Published var reloadID = UUID()
    
    func reload() {
        reloadID = UUID()
    }
}
