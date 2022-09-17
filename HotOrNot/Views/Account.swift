//
//  Account.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//

import SwiftUI

struct Account: View {
    var body: some View {
        ZStack {
            Color.blue
            
            Image(systemName: "person.fill")
                .foregroundColor(Color.white)
                .font(.system(size: 100.0))
        }
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}
