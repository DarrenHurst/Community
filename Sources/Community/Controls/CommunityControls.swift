import Foundation
import SwiftUI
import PhotosUI


@available(iOS 15.0, *)
struct InterationControls: View, Identifiable {
    var id: UUID = UUID()
    @State var showMessages: Bool = false
    var body: some View {
        return HStack {
            GeometryReader { r in
                HStack{
                    Image(systemName: "bubble.left")
                        .icon()
                        .foregroundColor(.black)
                        .onTapGesture {
                            showMessages = true
                        }
                    Text("Comments: 2").font(.Small).offset(x:-20)
                    Image(systemName: "heart.fill").foregroundColor(.red)
                }.frame(width: r.size.width/2 - 10, height: 50, alignment: .leading)
                HStack{
                    Image(systemName: "square.and.pencil")
                }.frame(width: r.size.width/2 - 40, height: 50, alignment: .trailing)
                    .background(.clear).offset(x: r.size.width/2)
               
            }.frame(height: 60)
        }.frame(width: UIScreen.screenWidth)
        .fullScreenCover(isPresented: $showMessages) {
            MessageCenter(showParticles: false).frame(width: UIScreen.screenWidth )
        }
    }
}

@available(iOS 15.0, *)
struct Controls {
    func header() -> some View {
        return VStack {
            Image("Community").shadow(radius: 2).opacity(1).frame(height:57, alignment: .center).offset(y:20)
        }.frame(alignment: .top).background(ViewConfig().headerColor.opacity(1.0)).foregroundColor(.white)
    }
    
    func interactionControls() -> any View {
        return InterationControls(showMessages: false)
    }
    
    func StreamPost(title: String, url: String) -> some View {
        //let cornerRadius: CGFloat = 15.0
        let offsetFrame: CGFloat = 0
        let viewHeight: CGFloat = 220
        return Section {
            VStack {
                FullScreenModalView(title: title, url: url, width: UIScreen.screenWidth, height: viewHeight)
                    .frame(height: viewHeight).offset(y:offsetFrame)
            }
        } header: {
            Text(title).foregroundColor(.white).padding(10).frame(height:25)
        } footer: {
            AnyView(self.interactionControls()).padding(.top, -20).padding(.bottom, -20)
        }.background(.clear)  
    }
    
    func StreamPosts(url: String) -> some View {
        //let cornerRadius: CGFloat = 0
        let offsetFrame: CGFloat = 0
        let viewHeight: CGFloat = 80
          return Section {
            GeometryReader { reader in
                HStack {

                    FullScreenModalView(title: "Elephants", url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", width: reader.size.width / 3, height: 480/6)
                        .frame(height: viewHeight).offset(y:offsetFrame)
                    FullScreenModalView(title: "Bigger Blazes", url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", width: reader.size.width / 3, height: 480/6)
                        .frame(height: viewHeight).offset(y:offsetFrame)
                    FullScreenModalView(title: "", url: url, width: reader.size.width / 3, height: 480/6)
                        .frame(height: viewHeight).offset(y:offsetFrame)
                }.background(.clear).frame(height:80)
                    //.offset(y:-30)
            }.background(.clear)
        }.background(.clear).frame(height:80)
    }
    

    func profileImage() -> some View {
        return  Image("profile")
    }
    
    @available(iOS 15.0, *)
    func ImagePost() -> some View {
    Section {
        Image("park").resizable()
        } footer: {
        AnyView(self.interactionControls())
        }.background(.clear)
    }
    
    func TextPost() -> some View {
        return Section {
            VStack {
                Text("LIVE UPDATES: Messy commute expected as cleanup from winter storm continues").padding(5).opacity(0.4)
            }
        } header: {
            Text("Notes").foregroundColor(.black).frame(height:50)
        } footer: {
            AnyView(self.interactionControls())
        }.cornerRadius(15)
    }
    
}
