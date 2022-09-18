//
//  ChooseOutfit.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//

import SwiftUI

struct ConfirmOutfit: View {
    @State private var image: OutfitImage?
    
    var rate: () -> Void
    var retake: () -> Void
    
    init(image: OutfitImage?, rate: @escaping () -> Void, retake: @escaping () -> Void) {
        self.image = image
        self.rate = rate
        self.retake = retake
    }

    var body: some View {
        image?.image?
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: deviceWidth * 0.65)
            .cornerRadius(20)
        // spacer
        Text("  ")
            .font(.system(size:30.0))
        VStack(spacing: -8) {
            LargeButton(
                title: "Rate my outfit",
                backgroundColor: Color.purple
            ) { rate() }
            LargeButton(
                title: "Retake picture",
                backgroundColor: Color.white,
                foregroundColor: Color.gray
            ) { retake() }
        }
    }
}

struct ConfirmOutfit_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmOutfit(
            image: nil,
            rate: {},
            retake: {}
        )
    }
}
