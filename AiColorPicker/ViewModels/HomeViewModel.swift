import Foundation
import SwiftUI

@Observable
final class HomeViewModel {
    var mainColor: Color = .blue
    var colorCount: Int = 3
    var prompt: String = ""
    var showColorPicker = false
}
