//
//  UploadOutfit.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//

import SwiftUI

struct UploadOutfit: View {
    @State var outfitImg: OutfitImage? = OutfitImage(img: nil)
    @State var localImage: Image? = nil
    @State var localUIImage: UIImage? = nil
    @State var isUploaded = false
    @State var isCurrentlyRated = false
    @State var rating = 1
    
    @State private var shouldShowImagePicker = false
    @State private var shouldShowActionSheet = false
    @State private var shouldShowCamera = false
    
    let service = APIService()
    
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
        if (localUIImage != nil) {
            let postedImage: UIImage = localUIImage!
            let imageData: Data = postedImage.jpegData(compressionQuality: 1)!
            service.requestNativeImageUpload(image: postedImage) { [self] result in
                switch result {
                case .success(let result):

                    // Update UI using main thread
                    DispatchQueue.main.async {
                        
                        // Update collection view content
                        if result == "HOT" {
                            rating = 1
                        } else {
                            rating = 0
                        }
                    }
                    
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
        }
    }
    
    func retakeOutfit() {
        self.shouldShowActionSheet = true
        resetCam()
    }
    
    func retakeOutfitAfterRate() {
        self.shouldShowActionSheet = true
        resetCam()
        isCurrentlyRated = false
    }
    
    func saveOutfit() {
        // save outfit to calendar
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("Upload your outfit")
                    .font(.system(size:30.0))
                    .bold()
                    .frame(height: deviceHeight * 0.05, alignment: .top)
                if localImage == nil {
                    ChooseOutfit(image: outfitImg, onUploadPicture: onUploadPic)
                } else {
                    if isCurrentlyRated == false {
                        ConfirmOutfit(image: outfitImg, rate: rateOutfit, retake: retakeOutfit)
                    } else {
                        RatingResult(image: outfitImg, result: rating, save: saveOutfit, retake: retakeOutfitAfterRate)
                    }
                }
            }
            .sheet(isPresented: $shouldShowImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    self.outfitImg?.image = Image(uiImage: image)
                    localUIImage = image
                    localImage = Image(uiImage: image)
                }
            }
            .sheet(isPresented: $shouldShowCamera) {
                ImagePicker(sourceType: .camera) { image in
                    self.outfitImg?.image = Image(uiImage: image)
                    localUIImage = image
                    localImage = Image(uiImage: image)
                }
            }
            .actionSheet(isPresented: $shouldShowActionSheet) { () -> ActionSheet in
                    ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                        self.shouldShowImagePicker = false
                        self.shouldShowCamera = true
                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
                        self.shouldShowImagePicker = true
                        self.shouldShowCamera = false
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
