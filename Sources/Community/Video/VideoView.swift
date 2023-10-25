import Foundation
import SwiftUI
import AVKit
import AVFoundation


@available(iOS 15.0, *)
struct FrameView: View  {
    var image: CGImage?
    private let label = Text("Camera feed")
    
    var body: some View {
        if let image = image {
          // 2
          GeometryReader { geometry in
            // 3
            Image(image, scale: 1.0, orientation: .upMirrored, label: label)
              .resizable()
              .scaledToFill()
              .frame(
                width: geometry.size.width,
                height: geometry.size.height,
                alignment: .center)
              .clipped()
          }
        } else {
          // 4
          Color.black
        }
    }
 
        
}

// ** let view = View
//    return view



@available(iOS 15.0, *)
public struct VideoView: View{
    let numberOfColumns = 3.0
    let c: Community = Community()
    @State var image: Image =  Image("story", bundle: .module)
    @StateObject private var model = ContentViewModel()
 
    init() {}
    
    public var body: some View {
        GeometryReader { r in
        VStack {
                VStack {
                   //image.resizable()
                     FrameView(image: model.frame)
                      .edgesIgnoringSafeArea(.all)
                }.frame(height: r.size.height - 100).background(.black).font(  .Large).foregroundColor(.white)
                HStack {
                    VStack {}.frame(width: r.size.width / numberOfColumns)
                    
                    VStack {
                       
                        ZStack {
                            Circle().fill(.red.opacity(0.8)).frame(width: 80)
                                .shadow(color:.white.opacity(0.7), radius: 8.0)
                                .onTapGesture {
                                  
                                }
                        }.zIndex(2)
                    }.frame(width: r.size.width / numberOfColumns)
                    
                    VStack {}.frame(width: r.size.width / numberOfColumns)
                   
                }.frame(width: r.size.width, height:100, alignment: .bottom)
            }
        .frame(alignment: .bottom)
        .background(.black.opacity(0.9))
        
        }
    }
    
}

@available(iOS 15.0, *)
struct VideoViewPreview: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
 
enum CameraError: Error {
    case deniedAuthorization
    case restrictedAuthorization
    case unknownAuthorization
    case cameraUnavailable
    case cannotAddInput
    case createCaptureInput(_ error: Error)
    case cannotAddOutput
}

class CameraManager: ObservableObject {
    
    @Published var error: CameraError?
 
    let session = AVCaptureSession()
 
    private let sessionQueue = DispatchQueue(label: "community.feed.postType.video")
    
    private let videoOutput = AVCaptureVideoDataOutput()
    private var status = Status.unconfigured
    
 
  enum Status {
    case unconfigured
    case configured
    case unauthorized
    case failed
  }
 
  static let shared = CameraManager()
 
   init() {
    configure()
  }
  
    func configure() {
        checkPermissions()
        sessionQueue.async {
          self.configureCaptureSession()
          self.session.startRunning()
        }
    
    }
  
    func set(
      _ delegate: AVCaptureVideoDataOutputSampleBufferDelegate,
      queue: DispatchQueue
    ) {
      sessionQueue.async {
        self.videoOutput.setSampleBufferDelegate(delegate, queue: queue)
      }
    }
    
    private func set(error: CameraError?) {
      DispatchQueue.main.async {
        self.error = error
      }
    }
    
    private func checkPermissions() {
  
      switch AVCaptureDevice.authorizationStatus(for: .video) {
      case .notDetermined:
     
        sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: .video) { authorized in
         
          if !authorized {
            self.status = .unauthorized
            self.set(error: .deniedAuthorization)
          }
          self.sessionQueue.resume()
        }
 
      case .restricted:
        status = .unauthorized
        set(error: .restrictedAuthorization)
      case .denied:
        status = .unauthorized
        set(error: .deniedAuthorization)
   
      case .authorized:
        break
 
      @unknown default:
        status = .unauthorized
        set(error: .unknownAuthorization)
      }
    }

    
    private func configureCaptureSession() {
      guard status == .unconfigured else {
        return
      }
      session.beginConfiguration()
      defer {
        session.commitConfiguration()
      }
        
        let device = AVCaptureDevice.default(
          .builtInWideAngleCamera,
          for: .video,
          position: .front)
        guard let camera = device else {
          set(error: .cameraUnavailable)
          status = .failed
          return
        }
        
        do {
        
          let cameraInput = try AVCaptureDeviceInput(device: camera)
     
          if session.canAddInput(cameraInput) {
            session.addInput(cameraInput)
          } else {
    
            set(error: .cannotAddInput)
            status = .failed
            return
          }
        } catch {
 
          set(error: .createCaptureInput(error))
          status = .failed
          return
        }
        
            if session.canAddOutput(videoOutput) {
          session.addOutput(videoOutput)
    
          videoOutput.videoSettings =
            [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
 
          let videoConnection = videoOutput.connection(with: .video)
          videoConnection?.videoOrientation = .portrait
        } else {
 
          set(error: .cannotAddOutput)
          status = .failed
          return
        }
        
        status = .configured
    }

}

 
class FrameManager: NSObject, ObservableObject {
 
  static let shared = FrameManager()
 
  @Published var current: CVPixelBuffer?
 
  let videoOutputQueue = DispatchQueue(
    label: "community.feed.postType.video",
    qos: .userInitiated,
    attributes: [],
    autoreleaseFrequency: .workItem)
 
  private override init() {
    super.init()
    CameraManager.shared.set(self, queue: videoOutputQueue)
  }
}

extension FrameManager: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(
    _ output: AVCaptureOutput,
    didOutput sampleBuffer: CMSampleBuffer,
    from connection: AVCaptureConnection
  ) {
    if let buffer = sampleBuffer.imageBuffer {
      DispatchQueue.main.async {
        self.current = buffer
      }
    }
  }
}


import CoreGraphics
import CoreImage

@available(iOS 15.0, *)
class ContentViewModel: ObservableObject {
    // 1
    @Published var frame: CGImage?
    // 2
    private let frameManager = FrameManager.shared
    
    init() {
        setupSubscriptions()
    }
   
    
    func setupSubscriptions() {
        frameManager.$current
            .receive(on: RunLoop.main)
            .compactMap { $0 }
            .compactMap { buffer in
                return self.createCGImage(from: buffer) ?? .none
            }
            .assign(to: &$frame)
    }
    
    func createCGImage(from pixelBuffer: CVPixelBuffer) -> CGImage? {
       let ciContext = CIContext()
       var ciImage = CIImage(cvImageBuffer: pixelBuffer)
        ciImage = ciImage.applyingFilter("CIComicEffect")
       return ciContext.createCGImage(ciImage, from: ciImage.extent)
    }
}


 
