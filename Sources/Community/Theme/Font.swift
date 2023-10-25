//
//  Font.swift
//  test
//
//  Created by Darren Hurst on 2021-04-02.
//

import SwiftUI

@available(iOS 13.0, *)
extension Font {
    
    static func loadFonts() {
            // Register fonts to app, without using the Info.plist.... :smiling_imp:

        if let fontURLs = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: "inter-Black") {
                
                    CTFontManagerRegisterFontURLs(fontURLs as CFArray, .process, true, nil)
               
            }
        
        if let fontURLs = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: "inter-Regular") {
               
                    CTFontManagerRegisterFontURLs(fontURLs as CFArray, .process, true, nil)
                 
            }
        
        }
    
    
    
    public static var LargeBoldFont: Font {
        loadFonts()
        return Font.custom("Cookie-Regular", size: 38).bold()
    }
    
    public static var Small: Font {
    
        return Font.custom("Helvetica-Neue", size: 12)
    }
    public static var Medium: Font {
     
        return Font.custom("Helvetica-Neue", size: 14)
    }
    public static var Large: Font {
        loadFonts()
        return Font.custom("Helvetica-Neue", size: 24)
    }
    public static var XLarge: Font {
        loadFonts()
        return Font.custom("Cookie-Regular", size:42)
    }
    
    public static var Heading: Font {
        loadFonts()
        return Font.custom("Inter-Black", size: 42)
    }
    public static var SubHeading: Font {
        loadFonts()
        return Font.custom("Inter-Regular", size: 21)
    }
    
    public static var Copy: Font {
        loadFonts()
        return Font.custom("Inter-Black", size: 19)
    }
    public static var XXLarge: Font {
     
        return Font.custom("Helvetica-Neue", size: 55).bold()
    }
    public static var StandardFont: Font {
        return Font.custom("Helvetica-Neue", size: 18).bold()
    }
    
    public static var TickerFont: Font {
        return Font.custom("HelveticaNeue-italic", size: 12)
    }
    
}

@available(iOS 15.0, *)
extension LinearGradient {
    public static var offGradient: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.black, .gray.opacity(0.5), .white, .white.opacity(0.5), .gray, .black]), startPoint: .top, endPoint: .bottom)
    }
    public static var pinkToBlack: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.pink, .red.opacity(0.5),.pink]), startPoint: .top, endPoint: .bottom)
    }
    public static var blackblue: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.black, .cyan.opacity(0.45), .black.opacity(0.8), .blue, .black]), startPoint: .top, endPoint: .bottom)
    }
    public static var whiteToGreen: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.white, .white, .white, .gray.opacity(0.3), .green.opacity(0.5), .green]), startPoint: .top, endPoint: .bottom)
    }
}

@available(iOS 15.0, *)
extension RadialGradient {
    public static var  fun: RadialGradient {
        return RadialGradient(gradient: Gradient(colors: [.yellow,.orange, .white]), center: .center, startRadius: 57, endRadius: 5500)
    }}

@available(iOS 15.0, *)
struct BorderFrame: Shape {
    var paths:[CGPoint]
    init() {
        paths = []
    }
    
     var animatableData: [CGPoint] {
       get { paths }
       set { paths = newValue }
     }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius: CGFloat = 1.0
        let trs = CGPoint(x: UIScreen.screenWidth - radius, y: 0)
        let tr = CGPoint(x: Int(UIScreen.screenWidth  - radius), y: 0)
        let br = CGPoint(x: UIScreen.screenWidth - radius, y: UIScreen.screenHeight - radius  )
        
        let bl = CGPoint(x: radius + radius, y: UIScreen.screenHeight)
        let tl = CGPoint(x: radius , y: 0 + radius )
        
        path.move(to: CGPoint(x:  radius + radius, y: 0))
        // path.addLine(to: CGPoint(x: 10, y: 40))
        path.addArc(tangent1End: CGPoint(x: trs.x, y: 0) , tangent2End: CGPoint(x: tr.x, y: tr.y + 5) , radius: radius)
           // path.addLine(to: tre)\
        path.addLine(to: br)
        path.addArc(tangent1End: CGPoint(x: br.x, y: br.y + radius) , tangent2End: CGPoint(x: br.x - radius, y: br.y + radius) , radius: radius)
        path.addLine(to: bl)
        path.addArc(tangent1End: CGPoint(x: bl.x - radius  , y: bl.y  ) , tangent2End: CGPoint(x: bl.x - radius, y: bl.y - radius) , radius: radius)
        path.addLine(to: tl)
        path.addArc(tangent1End: CGPoint(x: tl.x    , y: tl.y - radius ) , tangent2End: CGPoint(x: tl.x + radius , y: tl.y - radius) , radius: radius)
        return path
       
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}


// Standard View   VStack, HStack
@available(iOS 15.0, *)
struct Standard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight).background(Color.clear).padding(.top,57).padding(.bottom, 20)
    }
}
@available(iOS 15.0, *)
struct ListFrame: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight).background(Color.clear)
    }
}
@available(iOS 15.0, *)
struct Top: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(alignment: .top)
    }
}
@available(iOS 15.0, *)
struct Bottom: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(alignment: .bottom)
    }
}
@available(iOS 15.0, *)
struct Icon: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 70, height: 70).background(Color.clear)
           
    }
}
@available(iOS 15.0, *)
struct IconSmall: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 30, height: 30).background(Color.clear)
           
    }
}
@available(iOS 15.0, *)
extension Image {
    func imageThumbnailXLarge() -> some View {
        modifier(ImageThumbnail())
    }
}
@available(iOS 15.0, *)
struct ImageThumbnail: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.clear)
            .foregroundColor(.blue)
            .border(.bar, width: 2)
            .font(.XLarge)
    }
}

@available(iOS 15.0, *)
extension View {
    func standard() -> some View {
       modifier(Standard())
    }
    func listframe() -> some View {
       modifier(ListFrame())
    }
    func icon() -> some View {
        modifier(Icon())
    }
    func iconSmall() -> some View {
        modifier(IconSmall())
    }
    
    
    func top() -> some View {
        modifier(Top())
    }
    
    func bottom() -> some View {
        modifier(Bottom())
    }
    
}

@available(iOS 15.0, *)
struct StandardButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .frame(height: 44, alignment: .center)
            .background(Color.white)
    }
}
@available(iOS 15.0, *)
extension Button {
    func standardButton() -> some View {
        modifier(StandardButton())
    }
}
@available(iOS 15.0, *)
struct OffStyle: ViewModifier {
    func body(content: Content) -> some View {
            content
                .font(.caption)
                .padding(10)
                .foregroundColor(Color.white)
                .background(Color.blue)
                //.border(Color.black, width: 4)
                .font(.Large)
                .scaledToFill()
        }
}
@available(iOS 15.0, *)
struct OnStyle: ViewModifier {
    func body(content: Content) -> some View {
            content
                .font(.caption)
                .padding(10)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .font(.Large)
                .scaledToFit()
        }
}
@available(iOS 15.0, *)
extension Button {
    func offStyle() -> some View {
        modifier(OffStyle())
    }
    func onStyle() -> some View {
        modifier(OnStyle())
    }
}




