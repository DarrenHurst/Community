import Foundation
import SwiftUI

@available(iOS 15.0, *)
struct PostType: Identifiable {
    var id: UUID = UUID()
    var postType: PostTypes
    var view: AnyView
    
    init(_ postType: PostTypes, view: AnyView) {
        self.postType = postType
        self.view = view
    }
}
