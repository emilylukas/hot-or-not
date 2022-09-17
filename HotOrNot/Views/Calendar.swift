//
//  Calendar.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//

import SwiftUI

struct Calendar: View {
    var body: some View {
        ZStack {
            Color.purple
            
            Image(systemName: "calendar")
                .foregroundColor(Color.white)
                .font(.system(size: 100.0))
        }
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}
