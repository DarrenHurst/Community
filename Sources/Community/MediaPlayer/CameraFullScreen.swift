//
//  CameraFullScreen.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-02.
//

import Foundation
import SwiftUI
import MobileVLCKit


@available(iOS 15.0, *)
struct FullScreenModalView:View, CardProtocol, Identifiable {
    @ObservedObject var playerState: PlayerState = PlayerState()
    
    var id: UUID = UUID()
    @State private var isPresented = false
    @State var isPlaying: Bool = true
 
    var playerWidth: CGFloat
    var playerHeight: CGFloat
    
    
        let title: String
        let url: String
    
    
    @Environment(\.dismiss) var dismiss
    
    init(title: String, url: String, width: CGFloat, height: CGFloat) {
            
        self.title = title
        self.url = url
        self.playerWidth = width
        self.playerHeight = height
        self.playerState.player = .init(url: url)
       
        }
    
        var body: some View {
               
            playerState.player
                        .frame(width: playerWidth, height: playerHeight)
                        .onAppear() {
                  
                            playerState.player?.play()
                            playerState.player?.mute()
                            playerState.player?.mediaPlayer.jumpForward(10)
                            playerState.player?.pause()
                            playerState.isPlaying = false
                    }
                    .onDisappear(){
                        playerState.player?.stop()
                        playerState.isPlaying = false
                    }
                    
                    .onTapGesture {
                        playerState.player?.toggleVolume()
                        playerState.isPlaying ? playerState.player?.pause() : playerState.player?.play()
                        playerState.isPlaying = playerState.isPlaying ? false : true
                       
                     
                
               
                    
                 
                   // PlayerControls(playerState: playerState, player: player).font(.Large).frame(height: g.size.width)
                
            }.background(.black)
           
        }
}

@available(iOS 15.0, *)
struct CameraFullScreen: View, Identifiable {
    var id: UUID = UUID()
    @ObservedObject var playerState: PlayerState = PlayerState()
    var player: PlayerView
    var url: String = ""
    var title: String = ""
    
    @Environment(\.dismiss) var dismiss
    init(playerState: PlayerState, player: PlayerView) {
        self.id = UUID()
        self.playerState = playerState
        self.player = player
        self.url = playerState.url ?? ""
        self.title = playerState.title ?? ""
    }
    var body: some View {
        VStack {
            Color.primary.edgesIgnoringSafeArea(.all)
        
            PlayerView(url: playerState.url ?? "" ).standard().onAppear(){
                
            }.onTapGesture {
          
            }
          //  PlayerControls(playerState: playerState, player: player).font(.Large).frame(alignment: .bottom).offset(y:-150)
        }.background(Color.primary).frame(alignment: .center)

    }
}

@available(iOS 15.0, *)
struct PreviewCameraView : PreviewProvider {
    static var previews: some View {
        CameraFullScreen(playerState: PlayerState(), player: PlayerView(url: "") )
    }
}
