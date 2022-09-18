//
//  RatingResult.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//

import SwiftUI

struct RatingResult: View {
    @State private var image: OutfitImage?
    
    var save: () -> Void
    var retake: () -> Void
    var result: Int // 1 for good, 0 for bad
    
    init(image: OutfitImage?, result: Int, save: @escaping () -> Void, retake: @escaping () -> Void) {
        self.image = image
        self.result = result
        self.save = save
        self.retake = retake
    }
    
    func ratingText() -> Text {
        if (result == 1) {
            return Text("GREAT")
                .font(.system(size:30.0))
                .foregroundColor(Color.purple)
                .bold()
        } else {
            return Text("UGLY")
                .font(.system(size:30.0))
                .foregroundColor(Color.pink)
                .bold()
        }
    }
    
    var body: some View {
        image?.image?
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: deviceWidth * 0.65)
            .cornerRadius(20)
        Text("Your outfit is").font(.system(size:25.0))
        ratingText()
        Text(result == 1 ? "Have a good day!" : "You should change")
            .font(.system(size:25.0))
        HStack {
            LargeButton(
                title: "Retake",
                backgroundColor: Color.white,
                foregroundColor: Color.purple
            ) { retake() }
            LargeButton(
                title: "Save",
                backgroundColor: Color.white,
                foregroundColor: Color.blue
            ) { save() }
        }
    }
}

struct RatingResult_Previews: PreviewProvider {
    static var previews: some View {
        RatingResult(
            image: nil,
            result: 1,
            save: {},
            retake: {}
        )
    }
}
