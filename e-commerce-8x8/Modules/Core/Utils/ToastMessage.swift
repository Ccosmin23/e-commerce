//
//  ToastMessage.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - tapptitude on 06.09.2024.
//

import SwiftUI
import SwiftMessages

struct ToastMessage: View {
    let type: ToastMessageType
    let text: String
    @State var contentHeight: CGFloat = .zero
    
    var body: some View {
        VStack(spacing: .zero) {
            content
                .frame(height: contentHeight)
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 8)
    }
    
    private var content: some View {
        GeometryReader(content: { proxy in
            ZStack(alignment: .leading) {
                backgroundColor
                strokeView
                titleView
            }
            .onAppear {
                contentHeight = proxy.size.height
            }
        })
    }
}

//MARK: - view components
extension ToastMessage {
    private var backgroundColor: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(type == .error ? .red : .green)
    }
    
    private var strokeView: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(type == .error ? .red : .green, lineWidth: 1)
    }
    
    private var titleView: some View {
        Text(text)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
    }
    
    static func show(message: String, type: ToastMessageType = .error) {
        Task { @MainActor in
            let toast = ToastMessage(type: type, text: message)
            let controller = UIHostingController(rootView: toast)
            controller.view.backgroundColor = .clear
            
            var config = SwiftMessages.Config()
            config.presentationStyle = .top
            config.presentationContext = .window(windowLevel: .statusBar)
            
            SwiftMessages.show(config: config, view: controller.view)
        }
    }
    
    static func show(error: Error) {
        if error is CancellationError {
            return
        }
        
        let message = error.localizedDescription
        show(message: message)
    }
}

enum ToastMessageType {
    case info
    case error
}

//MARK: - preview
#Preview("Error ToastMessage") {
    ToastMessage(
        type: .error,
        text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    )
}

#Preview("Success ToastMessage") {
    ToastMessage(
        type: .info,
        text: "Lorem Ipsum is simply dummy text of the printing"
    )
}
