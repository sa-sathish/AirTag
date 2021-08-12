//
//  ContentView.swift
//  AirTagFinder
//
//  Created by sathish s on 11/08/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View{
        IntroView()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



extension View {
  func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
    NavigationView {
      ZStack {
        self
          .navigationBarTitle("")
          .navigationBarHidden(true)
        NavigationLink(
          destination: view
            .navigationBarTitle("")
            .navigationBarHidden(true),
          isActive: binding
        ) {
          EmptyView()
        }
      }
    }
  }
}
