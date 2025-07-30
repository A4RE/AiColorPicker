import SwiftUI
import UIKit

struct HomeView: View {
    
    @State private var viewModel = HomeViewModel()
    let size: CGSize
    
    var body: some View {
        
        NavigationStack {
            Form {
                
                Section("main_color") {
                    HStack {
                        Text("select_color")
                            .font(.headline)
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .frame(height: size.height * 0.12)
                            Circle()
                                .fill(viewModel.mainColor)
                                .frame(height: size.height * 0.11)
                                .onTapGesture {
                                    viewModel.showColorPicker.toggle()
                                }
                                .sheet(isPresented: $viewModel.showColorPicker) {
                                    UIKitColorPicker(color: $viewModel.mainColor, size: size)
                                        .presentationDetents([.large])
                                        .interactiveDismissDisabled(true)
                                }
                        }
                    }
                }
                
                Section("additional_colors_count") {
                    HStack {
                        Text("\(viewModel.colorCount)")
                            .font(.headline)
                        Spacer()
                        Stepper("", value: $viewModel.colorCount, in: 1...8)
                            .labelsHidden()
                    }
                    .padding(.vertical, size.height * 0.005)
                }
                
                Section("describe_color_purpose") {
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $viewModel.prompt)
                            .frame(minHeight: size.height * 0.05)
                        if viewModel.prompt.isEmpty {
                            Text("example_color_purpose")
                                .foregroundStyle(.secondary)
                                .padding(.top, size.height * 0.01)
                                .padding(.leading, size.width * 0.01)
                        }
                    }
                    .frame(maxHeight: size.height * 0.2)
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
            .navigationTitle("home_title")
            
            Button(action: {
                
            }) {
                Text("Сгенерировать палитру")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.mainColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.bottom)
            .padding(.horizontal)
        }
    }
}

#Preview {
    GeometryReader { geo in
        HomeView(size: geo.size)
    }
}
