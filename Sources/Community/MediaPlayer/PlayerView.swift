//
//  PlayerView.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-01.
//

import Foundation
import SwiftUI
import UIKit
import MobileVLCKit

@available(iOS 15.0, *)
struct PlayerView: UIViewRepresentable {
    public var url: String
    @State public var isPlaying: Bool = false
    @State var mediaPlayer = VLCMediaPlayer()

    init(url: String) {
        self.url = url
        self.mediaPlayer = VLCMediaPlayer()
    }
    
    func makeUIView(context: Context) -> UIView {
        let controller = UIView()
        self.mediaPlayer.drawable = controller
        guard let uri = URL(string:url) else { return controller }
        let media = VLCMedia(url: uri)
        //media.addOption(":network-caching=600")
        media.addOptions([// Add options here
               "network-caching": 300,
               "--rtsp-frame-buffer-size":100,
               "--vout": "ios",
               "--glconv" : "glconv_cvpx",
               "--rtsp-caching=": 150,
               "--tcp-caching=": 150,
               "--realrtsp-caching=": 150,
               "--h264-fps": 20.0,
               "--mms-timeout": 60000
           ])
        
        mediaPlayer.media = media
   
       
        return controller
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }
    func stop() {
        mediaPlayer.stop()
        self.isPlaying = false
    }
    func play() {
        mediaPlayer.play()
        self.isPlaying = true
    }
    func pause() {
        mediaPlayer.pause()
        self.isPlaying = false
    }
    func mute() {
        mediaPlayer.audio?.isMuted = true
    }
    func unmute() {
        mediaPlayer.audio?.isMuted = false
    }
    func toggleVolume() {
        mediaPlayer.audio?.isMuted = mediaPlayer.audio!.isMuted ? false : true
    }
    func togglePlayer() {
        mediaPlayer.isPlaying ? mediaPlayer.stop() : mediaPlayer.pause()
    }
 
}

