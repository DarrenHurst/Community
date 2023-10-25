import Foundation
import SwiftUI

@available(iOS 15.0, *)
struct MessageCenter: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var view:ViewModel = ViewModel()
    @State var text: String = ""
    @State private var particleSystem = ParticleView()
   
    @State var showParticles: Bool
    
    var controls: Controls = Controls()

  
    fileprivate func squareCloseButton() -> some View {
        return HStack {
            Image(systemName: "chevron.left.square.fill").onTapGesture {
                dismiss()
            }.padding(5).cornerRadius(25)
                .font(.Medium)
                .background(.white).opacity(0.8)
                .mask(Circle()).shadow(radius: 5)
                .offset(y:40)
        }
    }
    
    var body: some View {
        return VStack {
            ZStack {
                squareCloseButton().frame(width: 380, alignment: .leading).zIndex(2).offset(x: 15, y: 20).ignoresSafeArea()
                Color(.systemPink).ignoresSafeArea().frame(height: 58).zIndex(1)
            }.frame(alignment: .leading)
             GeometryReader { reader in
                 AnyView(particleView())
               
                 ScrollView(.vertical){
                    VStack {
                        VStack {
                            ForEach(view.messages) { item in
                                if (item.userid.contains("darren")) {
                                    userBubble(message: item.message)
                                } else {
                                    largeBubbleWithImage(message: item.message)
                                }
                            }
                        }.frame(alignment: .bottom)
                    }.frame(width:UIScreen.screenWidth, alignment: .bottom).padding(.top,40)
                    
                 }.background(LinearGradient.pinkToBlack).frame(width: UIScreen.screenWidth,height:reader.size.height, alignment: .bottom).offset(y:-11)
                 
                     .onAppear(){
                        view.loadMessages()
                    }
                    
            }.frame(width: UIScreen.screenWidth)
                    
            HStack {
                TextField("Message", text: $text).padding(.leading, 20)
                    .onSubmit {
                        handleMessageInput()
                    }
            }.frame(height: 80, alignment: .top)
        }
       
        .standard().frame(alignment: .bottom).onTapGesture {
            self.showParticles = false
        }
    }
}

@available(iOS 15.0, *)
struct MessageCenterPreview: PreviewProvider {
    static var previews: some View {
        return MessageCenter(showParticles: false)
    }
}

struct MessageBuilder: Identifiable {
    var id: UUID = UUID()
    var message: String
    var userid: String
}

@available(iOS 15.0, *)
extension MessageCenter {
    
    class ViewModel : ObservableObject {
        
        @Published var messages: Array<MessageBuilder>
        
        init() {
            messages = []
        }
        
        func loadMessages() {
            messages.append(MessageBuilder(id: UUID(), message: "Please let me know so i can stop at the store", userid: "dhurst13423423somehash"))
            
            messages.append(MessageBuilder(id: UUID(), message: "Did you get the stuff for mom? She's really upset. needs you to get it!", userid: "dhurst13423423somehash"))
              }
    }
}
@available(iOS 15.0, *)
extension MessageCenter {
    
    fileprivate func largeBubble(message: String) -> some View {
       HStack{
            
         Text(message)
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
            .shadow(radius: 4)
            .frame(width: 200, alignment: .bottomLeading)
            .padding(.leading,20)
            .padding(.top, 20)
            .padding(.trailing, 20)
            .padding(.bottom, 50)
            .background(Image(systemName: "bubble.left.fill").resizable()
                .foregroundColor(.blue).frame(alignment: .leading).shadow(radius: 4))
            .padding(10)
        //Image("profile").animation(.ripple(), value: showMessage)
    }
                
    }
    
    fileprivate func smallBubble() -> some View {
        Text("Hi....")
            .foregroundColor(.white)
            .shadow(radius: 3)
            .frame(width:100, height: 50, alignment: .leading)
            .padding(20)
            .background(Image(systemName: "bubble.left.fill").resizable().foregroundColor(.blue).frame(alignment: .leading).shadow(radius: 4))
         
    }
    
    fileprivate func userBubble(message: String) -> some View {
         Text("\(message)")
            .foregroundColor(.white)
            .shadow(radius: 3)
            .padding(.bottom , 20)
            .background(Image(systemName: "bubble.right.fill")
                .resizable()
                .padding(-20)
                .foregroundColor(.red)
                .frame(alignment: .leading)
                .shadow(radius: 4))
            .frame(width: 200, alignment: .trailing)
            .offset(x: 40, y:-70 )
            .padding(.bottom, 40)
    }

    fileprivate func particleView() -> any View {
        if (showParticles){
            return  ZStack {
             particleSystem.opacity(showParticles ? 1 : 0).opacity(showParticles ? 0.5 : 1)
            }
        }
        return ZStack{
            
        }
    }
    
    fileprivate func largeBubbleWithImage(message: String) -> some View {
        HStack {
            controls.profileImage()
            largeBubble(message: message).padding(10).offset(x: -50, y: -50)
        }.padding(20)
    }
    
    fileprivate func handleMessageInput() {
        self.showParticles = text.lowercased().contains("love")
        view.messages.append(MessageBuilder(id: UUID(), message: "\(text)", userid: "darren"))
        text = ""
    }
    
}
