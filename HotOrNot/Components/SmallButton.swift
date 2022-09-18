//
//  SmallButton.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//

import SwiftUI

struct SmallButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
    let foregroundColor: Color
    let isDisabled: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        return configuration.label
            .padding()
            .foregroundColor(currentForegroundColor)
            .background(isDisabled || configuration.isPressed ? backgroundColor.opacity(0.3) : backgroundColor)
            // This is the key part, we are using both an overlay as well as cornerRadius
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(currentForegroundColor, lineWidth: 1)
        )
            .frame(width: deviceWidth * 0.3, height: deviceHeight * 0.1)
            .font(Font.system(size: 15))
    }
}

struct SmallButton: View {
    
    private static let buttonHorizontalMargins: CGFloat = 20
    
    var backgroundColor: Color
    var foregroundColor: Color
    
    private let title: String
    private let action: () -> Void
    
    private let disabled: Bool
    
    init(title: String,
         disabled: Bool = false,
         backgroundColor: Color,
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
            Spacer(minLength: SmallButton.buttonHorizontalMargins)
            Button(action:self.action) {
                Text(self.title)
                    .frame(maxWidth:.infinity)
            }
            .buttonStyle(LargeButtonStyle(backgroundColor: backgroundColor,
                                          foregroundColor: foregroundColor,
                                          isDisabled: disabled))
                .disabled(self.disabled)
            Spacer(minLength: SmallButton.buttonHorizontalMargins)
        }
        .frame(maxWidth:.infinity)
    }
}

