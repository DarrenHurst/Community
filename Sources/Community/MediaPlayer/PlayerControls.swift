//
//  PlayerControls.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-02.
//

import Foundation
import SwiftUI
@available(iOS 15.0, *)
struct PlayerControls : View {
    let play = Image(systemName: "play")
    let pause = Image(systemName: "pause")
    
    @ObservedObject var playerState: PlayerState
    var player: PlayerView
    @State var progress = 0.0
    
    init(playerState: PlayerState, player: PlayerView) {
        self.playerState = playerState
        self.player = player
    }
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: playerState.isPlaying ? "pause" : "play").onAppear(){
                    player.play()
                    playerState.isPlaying = true
                }.onTapGesture {
                    //playerState.isPlaying = playerState.isPlaying ? true : false
                    if playerState.isPlaying {
                        player.pause()
         
                    } else {
                        player.play()
                   
                    }
                    playerState.isPlaying = playerState.isPlaying ? false : true
                }.padding(.trailing, 20).padding(.leading, 20)
                
                Slider(value: $progress) {
                    Text("0")
                } minimumValueLabel: {
                    Text("1")
                } maximumValueLabel: {
                    Text("100")
                }
                
            }.background(.black).foregroundColor(.white).offset(y:-10)
        }.zIndex(10)
    }
}
