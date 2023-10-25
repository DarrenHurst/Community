
import Foundation
import SwiftUI
import PhotosUI

@available(iOS 15.0, *)
struct BackButton: View {
    var dismissAction: () -> Void
    
    var btnBack : some View { Button(action: {
            self.dismissAction()
        }) {
           HStack {
               Image(systemName: "arrow.left")
               //Image(systemName: "chevron.left.circle")
               .aspectRatio(contentMode: .fit)
               .foregroundColor(.white)
           }.background(.clear)
           //.border(.bar, width: 2)
           .foregroundColor(.black)
        }
    }
    
    var btnBackRoot : some View { Button(action: {
            self.dismissAction()
        }) {
           HStack {
               
           }.background(.clear)
           //.border(.bar, width: 2)
           .foregroundColor(.black)
        }
    }
    var body: some View {
        VStack {
            AnyView {
                btnBackRoot
            }
        }
    }
    
   

}

@available(iOS 16.0, *)
struct NavigationBack: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var selectedItems: [PhotosPickerItem] = []
    func body(content: Content) -> some View {
        content
            .navigationTitle(Text(""))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(dismissAction: {
                self.presentationMode.wrappedValue.dismiss()
            }).btnBack, trailing:
                                    PhotosPicker(selection: $selectedItems,
                                                       matching: .images) {
                                              Text("Select Multiple Photos")
                                          })
                                    //Image(systemName: "plus.circle.fill").foregroundColor(.white)).onTapGesture {
                
            
    }
}

@available(iOS 16.0, *)
struct NavigationBackRoot: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var selectedItems: [PhotosPickerItem] = []
    func body(content: Content) -> some View {
        content
            .navigationTitle(Text(""))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(dismissAction: {
                self.presentationMode.wrappedValue.dismiss()
            }).btnBackRoot, trailing: PhotosPicker(selection: $selectedItems,
                                                   matching: .images) {
                Image(systemName: "plus.circle.fill").foregroundColor(.white)
                                      })
    }
}

@available(iOS 16.0, *)
extension View {
    // install on view with .backButton()
    func backButton() -> some View {
        modifier(NavigationBack())
    }
    
    func backButtonRoot() -> some View {
        modifier(NavigationBackRoot())
    }
}


