//
//  Outfit.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//

import Foundation
import SwiftUI

class OutfitImage {
    var image: Image?
    
    init(img: Image?) {
        image = img
    }
    
    func setImage(img: Image) {
        image = img
    }
}
