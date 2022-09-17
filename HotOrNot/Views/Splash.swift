//
//  Splash.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//

import SwiftUI

struct Splash: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                ZStack {
                    LinearGradient(colors: [.pink, .purple],
                                           startPoint: .top,
                                   endPoint: .bottomLeading)
                        .ignoresSafeArea()
                    Text("Hot or Not")
                        .font(.custom("SignPainter",
                                      size: 70))
                        .foregroundColor(Color.white)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.isActive = true
                }
            }
        }
    }
}

struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}
