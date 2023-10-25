
import Foundation
import AVKit
@available(iOS 15.0, *)
struct MockStore {
    
    var str: String = " "

    static var cards = [
        Card(playerState: PlayerState(), title: "Mac Ad", url:"https://swiftanytime-content.s3.ap-south-1.amazonaws.com/SwiftUI-Beginner/Video-Player/iMacAdvertisement.mp4"),
         Card(playerState: PlayerState(), title: "Bunny", url:"rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4")
    ]
    
    func sm() {
        let x = " sfasdf "
        print(x)
    }
}
