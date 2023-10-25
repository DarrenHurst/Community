import XCTest
import SwiftUI
@testable import Community

@available(iOS 15.0, *)
final class CommunityTests: XCTestCase {
    let bunny: String = "rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4"

    let control: Controls = Controls()
 
    func testCommunityHasImageType() throws {
        let post1 = PostType(.video, view: AnyView(control.StreamPost(title:"Big Buck Bunny", url: bunny)))
        let post2 = PostType(.image, view: AnyView(control.ImagePost()))
        let post3 = PostType(.text, view: AnyView(control.TextPost()))
        let post4 = PostType(.video, view: AnyView(control.StreamPosts(url: bunny)))
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //Given
        var viewData = [post1, post2, post4, post3 ]
        //When
        viewData = viewData.filter({$0.postType == .text || $0.postType == .video })
        //Then
        XCTAssertTrue(viewData.contains(where: { postType in
            postType.postType == .image
        }))
    }
    
    func testCommunityHasVideoType() throws {
        let post1 = PostType(.video, view: AnyView(control.StreamPost(title:"Big Buck Bunny", url: bunny)))
        let post2 = PostType(.image, view: AnyView(control.ImagePost()))
        let post3 = PostType(.text, view: AnyView(control.TextPost()))
        let post4 = PostType(.video, view: AnyView(control.StreamPosts(url: bunny)))
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //Given
         var viewData = [post1, post2, post4, post3 ]
        //When
        viewData = viewData.filter({$0.postType == .text || $0.postType == .image })
        //Then
        XCTAssertFalse(viewData.isEmpty)
    }
    
    func testCommunityHasTextType() throws {
        let post1 = PostType(.video, view: AnyView(control.StreamPost(title:"Big Buck Bunny", url: bunny)))
        let post2 = PostType(.image, view: AnyView(control.ImagePost()))
        let post3 = PostType(.text, view: AnyView(control.TextPost()))
        let post4 = PostType(.video, view: AnyView(control.StreamPosts(url: bunny)))
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //Given
         var viewData = [post1, post2, post4, post3 ]
        //When
        viewData = viewData.filter({$0.postType == .video || $0.postType == .image })
        //Then
        XCTAssertFalse(viewData.isEmpty)
    }
}
