
import Foundation
import SwiftUI
import UIKit



@available(iOS 15.0, *)
struct CameraList: View {
    var cameras: [Camera] = Array()
    @State var isShowing: Bool = true
    
    init() {}

    var body: some View {
        Page(isPresented: $isShowing, backgroundColor: .red, view: AnyView(CameraListControl()))
            .standard()
       
    }
}
@available(iOS 15.0, *)
struct CardView: View {
    let title: String
    let url: String
    @ObservedObject var playerState: PlayerState
    var player: PlayerView
    
    init(title: String, url: String) {
        self.title = title
        self.url = url
        self.playerState = PlayerState()
        player = .init(url: url)
    }

    var body: some View {
        VStack {
            AnyView(player).onAppear() {
                player.pause()
            }
            .onDisappear(){
                player.pause()
            }
            .onTapGesture {
                player.mediaPlayer.position = 0
                playerState.isPlaying = true
                player.play()
            }
            Button(playerState.isPlaying ? "Pause" : "Play", action: {
                if playerState.isPlaying {
                    playerState.isPlaying = false
                    player.pause()
                } else {
                    playerState.isPlaying = true
                    player.play()
                }
            })
            Text(title)
                .font(.title2)
        }.padding(.top, 40)
    }
    
    func hashtags(in str: String) -> [ String ] {
        let words = str.components(separatedBy: .whitespacesAndNewlines)
        let tags = words.filter { $0.starts(with: "#") }
            return tags.map { $0.lowercased() }
    }
    
   
}
@available(iOS 15.0, *)
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Camera", url: "")
    }
}

@available(iOS 15.0, *)
struct RowView: View {
    
    let cards: [Card]
    let width: CGFloat
    let height: CGFloat
    let horizontalSpacing: CGFloat
   //@State var player = AVPlayer(url: URL(string: card.url)!)
    var body: some View {
        HStack(spacing: horizontalSpacing) {
            ForEach(cards) { card in
                CardView(title: card.title, url: card.url)
                    .frame(width: width, height: height)
                
            }
        }
        .padding()
    }
}
@available(iOS 15.0, *)
struct CameraListControl: View {
    let itemPerRow: CGFloat = 3
     let horizontalSpacing: CGFloat = 16
     let height: CGFloat = 200
    var cards: [Card] = MockStore.cards
    var backgroundColor: Color = .random
    
    var body: some View {
        GeometryReader { geometry in
                ScrollView {

        VStack(alignment: .leading, spacing: 8) {
                            ForEach(0..<cards.count) { i in
                                if i % Int(itemPerRow) == 0 {
                                    buildView(rowIndex: i, geometry: geometry)
                                }
                            }
                        }
                }.background(backgroundColor)
        }
    }
    
    func buildView(rowIndex: Int, geometry: GeometryProxy) -> RowView? {
            var rowCards = [Card]()
            for itemIndex in 0..<Int(itemPerRow) {
                if rowIndex + itemIndex < cards.count {
                    rowCards.append(cards[rowIndex + itemIndex])
                }
            }
            if !rowCards.isEmpty {
                return RowView(cards: rowCards, width: getWidth(geometry: geometry), height: height, horizontalSpacing: horizontalSpacing)
            }
            
            return nil
        }
        
        func getWidth(geometry: GeometryProxy) -> CGFloat {
            let width: CGFloat = (geometry.size.width - horizontalSpacing * (itemPerRow + 1)) / itemPerRow
            return width
        }
}
@available(iOS 15.0, *)
struct CameraListControlPreview : PreviewProvider {
    static var previews: some View {
        CameraList()
    }
}


