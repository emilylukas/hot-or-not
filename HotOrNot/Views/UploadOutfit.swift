//
//  UploadOutfit.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//

import SwiftUI

struct UploadOutfit: View {
        @State private var shouldPresentImagePicker = false
        @State private var shouldPresentActionSheet = false
        @State private var shouldPresentCamera = false
        @State var image: Image? = nil

        var body: some View {
            ZStack {
                VStack {
                    Text("Upload your outfit")
                        .font(.system(size:30.0))
                        .bold()
                    Button(action: {
                        // self.showImagePicker.toggle()
                        self.shouldPresentActionSheet = true
                    }) {
                        Text("Show image picker")
                    }
                    image?.resizable().frame(width: 100, height: 100)
                }
                .sheet(isPresented: $shouldPresentImagePicker) {
                    ImagePicker(sourceType: .photoLibrary) { image in
                        self.image = Image(uiImage: image)
                    }
                }
                .actionSheet(isPresented: $shouldPresentActionSheet) { () -> ActionSheet in
                        ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                            self.shouldPresentImagePicker = true
                            self.shouldPresentCamera = true
                        }), ActionSheet.Button.default(Text("Photo Library"), action: {
                            self.shouldPresentImagePicker = true
                            self.shouldPresentCamera = false
                        }), ActionSheet.Button.cancel()])
                    }
                }
            }
        }

struct UploadOutfit_Previews: PreviewProvider {
    static var previews: some View {
        UploadOutfit()
    }
}
