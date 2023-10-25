//
//  CommunityList.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-20.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
public struct FeedView: View {
   @State var isPresented: Bool = true
   public var body: some View {
       VStack {
           Page(isPresented: $isPresented, backgroundColor: .brown, view: AnyView(ScrollList().padding(.top,80).background(Color.random.opacity(0.7)))).ignoresSafeArea()
       } 
   }
}
@available(iOS 15.0, *)
struct FeedViewPreview: PreviewProvider {
   static var previews: some View {
       FeedView()
   }
}

@available(iOS 15.0, *)
struct ViewConfig {
    let tableViewBackground = Image("park").resizable()
    let tableViewColor = Color.blue.opacity(0.2)//Color.brown.opacity(0.2)
    let headerColor = Color.random.opacity(0.2)
    let pageColor = Color.random.opacity(0.2)
    let pageColorBackground =  LinearGradient(gradient: Gradient(colors: [.gray, .gray.opacity(0.45), .random.opacity(0.8), .blue, .black]), startPoint: .top, endPoint: .bottom)
}


@available(iOS 15.0, *)
extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
