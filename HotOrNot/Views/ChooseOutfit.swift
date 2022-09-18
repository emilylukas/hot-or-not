//
//  ChooseOutfit.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//

import SwiftUI

struct ChooseOutfit: View {
    @State private var image: OutfitImage?
    
    var onUploadPicture: () -> Void
    
    init(image: OutfitImage?, onUploadPicture: @escaping () -> Void) {
        self.image = image
        self.onUploadPicture = onUploadPicture
    }

    var body: some View {
        ImageSelector(
            title: "",
            disabled: image?.image != nil,
            backgroundColor: Color.white,
            foregroundColor: Color.pink
        ) {
            onUploadPicture()
        }
        Text("Will your outfit be")
            .font(.system(size:25.0))
            .frame(height: deviceHeight * 0.1, alignment: .bottom)
        HStack {
            Text("HOT")
                .font(.system(size:30.0))
                .foregroundColor(Color.purple)
                .bold()
            Text("or").font(.system(size:25.0))
            Text("NOT")
                .font(.system(size:30.0))
                .foregroundColor(Color.pink)
                .bold()
            Text("?").font(.system(size:25.0))
        }
    }
}

struct ChooseOutfit_Previews: PreviewProvider {
    static var previews: some View {
        ChooseOutfit(image: nil, onUploadPicture: {})
    }
}
