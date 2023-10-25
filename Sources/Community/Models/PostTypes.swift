//
//  File.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-22.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
enum PostTypes {
    case image
    case video
    case videos
    case text
    
    @ViewBuilder
       public func view() -> some View {
           switch self {
           case .image:
               Controls().ImagePost()
           case .video:
               Controls().StreamPost(title: "", url: "")
           case .videos:
               Controls().StreamPosts(url: "")
           case .text:
               Controls().TextPost()
           }
       }
}
