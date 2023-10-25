//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-03-11.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
struct Page : View {
    @Binding var isPresented : Bool // Bindable
    var backgroundColor: Color
    var view: AnyView
    @State private var opacity: Double? = 1.0 // internal state
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
    
        if(isPresented) {
           
            ZStack {
                VStack{}.background(backgroundColor)
                    .opacity((colorScheme == .light ? 0.15: 0.45) ?? 1.0)  //curtain
                AnyView(view)
            }.zIndex(10)
                .standard().top()
           // .background( colorScheme == .light ? Color.white: Color.black)
            .onDisappear(perform: {
            isPresented = false
            })
                
            
        }
    
    }
    
}
