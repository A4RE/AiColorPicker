import SwiftUI
import UIKit

struct UIKitColorPicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var color: Color
    let size: CGSize

    func makeUIViewController(context: Context) -> UIViewController {
        let container = UIViewController()

        let picker = UIColorPickerViewController()
        picker.delegate = context.coordinator
        picker.selectedColor = UIColor(color)

        container.addChild(picker)
        container.view.addSubview(picker.view)
        picker.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picker.view.topAnchor.constraint(equalTo: container.view.topAnchor),
            picker.view.bottomAnchor.constraint(equalTo: container.view.bottomAnchor),
            picker.view.leadingAnchor.constraint(equalTo: container.view.leadingAnchor),
            picker.view.trailingAnchor.constraint(equalTo: container.view.trailingAnchor)
        ])
        picker.didMove(toParent: container)

        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .label
        closeButton.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
        closeButton.layer.cornerRadius = 16
        closeButton.addTarget(context.coordinator, action: #selector(Coordinator.close), for: .touchUpInside)

        container.view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: container.view.safeAreaLayoutGuide.topAnchor, constant: size.height * 0.017),
            closeButton.leadingAnchor.constraint(equalTo: container.view.trailingAnchor, constant: -size.width * 0.12),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.heightAnchor.constraint(equalToConstant: 32)
        ])

        context.coordinator.presentationMode = presentationMode
        return container
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
        var parent: UIKitColorPicker
        var presentationMode: Binding<PresentationMode>?

        init(_ parent: UIKitColorPicker) {
            self.parent = parent
        }

        @objc func close() {
            presentationMode?.wrappedValue.dismiss()
        }

        func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            parent.color = Color(viewController.selectedColor)
        }
    }
}

