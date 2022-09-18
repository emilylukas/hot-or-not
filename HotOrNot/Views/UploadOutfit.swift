//
//  UploadOutfit.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//

import SwiftUI

struct UploadOutfit: View {
    @State var outfitImg: OutfitImage? = nil
    @State var isUploaded = false
    @State var isCurrentlyRated = false
    
    @State private var shouldShowImagePicker = false
    @State private var shouldShowActionSheet = false
    @State private var shouldShowCamera = false
    
    func onUploadPic() {
        shouldShowActionSheet = true
    }
    
    func resetCam() {
        self.shouldShowImagePicker = false
        self.shouldShowCamera = false
    }
    
    func rateOutfit() {
        self.shouldShowActionSheet = false
        resetCam()
        isCurrentlyRated = true
        // Add API call here
    }
    
    func retakeOutfit() {
        self.shouldShowActionSheet = true
        resetCam()
    }
    
    var body: some View {
        HStack {
            ZStack {
                VStack {
                    Text("Upload your outfit")
                        .font(.system(size:30.0))
                        .bold()
                        .frame(height: deviceHeight * 0.05, alignment: .top)
                    if outfitImg?.image == nil {
                        ChooseOutfit(image: outfitImg, onUploadPicture: onUploadPic)
                    } else {
                        if !isCurrentlyRated {
                            ConfirmOutfit(image: outfitImg, rate: rateOutfit, retake: retakeOutfit)
                        } else {
                           // rating result
                        }
                    }
                }
                .sheet(isPresented: $shouldShowImagePicker) {
                    ImagePicker(sourceType: .photoLibrary) { image in
                        self.outfitImg.image = Image(uiImage: outfitImg?.image)
                    }
                }
                .actionSheet(isPresented: $shouldShowActionSheet) { () -> ActionSheet in
                        ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                            self.shouldShowImagePicker = true
                            self.shouldShowCamera = true
                        }), ActionSheet.Button.default(Text("Photo Library"), action: {
                            self.shouldShowImagePicker = true
                            self.shouldShowCamera = false
                        }), ActionSheet.Button.cancel()])
                    }
                }
            }
        }
    }

struct UploadOutfit_Previews: PreviewProvider {
    static var previews: some View {
        UploadOutfit()
    }
}
