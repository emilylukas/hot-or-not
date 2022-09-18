//
//  ImageSelector.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//

import SwiftUI

var deviceWidth: CGFloat {
    UIScreen.main.bounds.width
}

var deviceHeight: CGFloat {
    UIScreen.main.bounds.height
}

struct ImageSelectorStyle: ButtonStyle {
    
    let backgroundColor: Color
    let foregroundColor: Color
    let isDisabled: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        return configuration.label
            .foregroundColor(currentForegroundColor)
            .background(isDisabled || configuration.isPressed ? backgroundColor.opacity(0.3) : backgroundColor)
            // This is the key part, we are using both an overlay as well as cornerRadius
            .cornerRadius(20)
            .frame(width: deviceWidth * 0.65, height: deviceHeight * 0.5)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(currentForegroundColor, lineWidth: 1)
        )
    }
}

struct ImageSelector: View {
    
    private static let buttonHorizontalMargins: CGFloat = 20
    
    var backgroundColor: Color
    var foregroundColor: Color
    
    private let title: String
    private let action: () -> Void
    
    private let disabled: Bool
    
    init(title: String,
         disabled: Bool = false,
         backgroundColor: Color = Color.green,
         foregroundColor: Color = Color.white,
         action: @escaping () -> Void) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.title = title
        self.action = action
        self.disabled = disabled
    }
    
    var body: some View {
        HStack {
            Spacer(minLength: ImageSelector.buttonHorizontalMargins)
            Button(action:self.action) {
                Image(systemName: "camera")
                    .font(.system(size: 80.0))
            }
            .buttonStyle(ImageSelectorStyle(backgroundColor: backgroundColor,
                                          foregroundColor: foregroundColor,
                                          isDisabled: disabled))
            .disabled(self.disabled)
            Spacer(minLength: ImageSelector.buttonHorizontalMargins)
        }
        .frame(maxWidth:.infinity)
    }
}
