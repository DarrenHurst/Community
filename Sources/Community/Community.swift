import SwiftUI
@available(iOS 15.0, *)
public struct Community {
    

    // returns Image
    public func profileImage() -> some View {
       Image("profile")
    }

    public func loadFeedView(_ feedItems: [ Any ]) -> some View {
        FeedView().ignoresSafeArea()
    }

    public init() {
    }
}

@available(iOS 13.0, *)
  struct basicPadding: ViewModifier {
    func body(content: Content) -> some View {
        content.padding(10)
    }
}

@available(iOS 13.0, *)
  extension View {
    func standardPadding() -> some View {
       modifier(basicPadding())
    }
  
}

@available(iOS 15.0, *)
struct FeedPreview : PreviewProvider {
    static var previews: some View {
        Community().loadFeedView( [ ] )
    }
}
