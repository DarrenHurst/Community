//
//  File.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-03.
//

import Foundation

@available(iOS 15.0, *)
class PlayerState: ObservableObject, Identifiable {
    var id: UUID = UUID()
    @Published var isPlaying: Bool = false
    @Published var url: String?
    @Published var title: String?
    @Published var isFullscreen: Bool = false
    var player: PlayerView?
    
    init(){
        self.url = nil
    }
}
