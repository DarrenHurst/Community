import Foundation
import SwiftUI

@available(iOS 15.0, *)
struct SectionDropDown:  View {
    // will take content
    @Binding var showView: Bool
    var body: some View {
              Section {
                  VStack {
                          HStack {
                              Text("Food Bank Donation").padding(5)
                              Image(systemName: "checkmark.circle.fill").resizable() .foregroundColor(.green).iconSmall()
                          }
                          HStack {
                              Text("Seed and Garden Prep").padding(5)
                              Image(systemName: "checkmark.circle.fill").resizable() .foregroundColor(.green).iconSmall()
                          }
                          Text("Book Club").padding(5).opacity(0.4)
                          Text("Recipes").padding(5)
                     // }
                  }.frame(height: showView ? 150 : 0) .animation(.default, value: showView).foregroundColor(.white).opacity(showView ? 1: 0)
                      .animation(.linear(duration: 0.8), value: showView)
                      
              }
               header: {
                   HStack {
                       Text("Welcome Checklist").foregroundColor(.white).frame(width: 320, alignment: .topLeading ).padding(.top,10)
                       Image(systemName: "chevron.right.circle.fill")
                           .frame(alignment: .bottomTrailing)
                           .rotationEffect(showView ? Angle(degrees:90.0) : Angle(degrees:0.0))
                           .animation(.linear(duration: 0.5), value: showView)
                          
                   } .onTapGesture {
                       showView = self.showView  ? false : true
                      
                   }
                   
               }.background(.clear).cornerRadius(15).foregroundColor(.white)
            
    }
}
