//
//  ContentView.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Account()
                .tabItem() {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
            UploadOutfit()
                .tabItem() {
                    Image(systemName: "tshirt")
                    Text("Upload Outfit")
                }
            Calendar()
                .tabItem() {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
