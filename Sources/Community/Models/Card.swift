//
//  Card.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-01-28.
//

import Foundation
import SwiftUI
@available(iOS 15.0, *)
struct Card: Identifiable, CardProtocol {
    var playerState: PlayerState
    
    let id = UUID()
    let title: String
    let url: String
   

}
@available(iOS 15.0, *)
protocol CardProtocol {
    var playerState: PlayerState { get set }
}


