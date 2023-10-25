
import Foundation
import SwiftUI
import CoreMotion

@available(iOS 15.0, *)
struct ParticleView : View {
    @State private var particleSystem = ParticleSystem()
    @State private var motionHandler = MotionManager()
    
    let timer = Timer.publish(every: 0.6, on: .current, in: .common).autoconnect()

    func randomPoint() -> CGPoint {
        let x = 0...UIScreen.screenWidth
        let y = 0...UIScreen.screenHeight
        return CGPoint(x: .random(in: x), y: .random(in:y))
     }
 
      
    var body: some View {
        
        
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                Task {
                  await particleSystem.update(date: timelineDate)
                }
                context.blendMode = .color
                let numberOfParticles = 6
                let particleRange: ClosedRange  = 0...numberOfParticles
                    for _ in particleRange {
                        
                        for particle in particleSystem.particles {
                            var contextCopy = context
                            contextCopy.addFilter(.colorMultiply(Color(hue: particle.hue, saturation: 1, brightness: 1)))
                            contextCopy.opacity = 1 - (timelineDate - particle.creationDate)
                            
                            let sleepTime : UInt32 = UInt32(0.6)
                            
                            var options: [CGPoint] = []
                            for _ in particleRange {
                                options.append(self.randomPoint())
                            }
                            for option in options {
                                
                                
                                contextCopy.draw(particleSystem.image, at: option)
                                
                            }
                            sleep(sleepTime)
                        }
                    }
            }
        }
        .ignoresSafeArea().standard().top()
        .background(.clear).foregroundColor(.white)
    }
}

@available(iOS 15.0, *)
struct ParticleViewPreview : PreviewProvider {
    static var previews: some View {
        ParticleView()
    }
}

@available(iOS 15.0, *)
class MotionManager {
    private var motionManager = CMMotionManager()
    var pitch = 0.0
    var roll = 0.0
    var yaw = 0.0
    
    init() {
        //motionManager.startDeviceMotionUpdates(to: OperationQueue()) { [weak self] motion, error in
         //   guard let self = self, let motion = motion else { return }
          //  self.pitch = motion.attitude.pitch
           // self.roll = motion.attitude.roll
           // self.yaw = motion.attitude.yaw
        //}
    }
    deinit {
       // motionManager.stopDeviceMotionUpdates()
    }
}

@available(iOS 15.0, *)
struct Particle: Hashable {
    let x: Double
    let y: Double
    let creationDate = Date.now.timeIntervalSinceReferenceDate
    let hue: Double
}

@available(iOS 15.0, *)
class ParticleSystem {
    let image = Image(systemName: "heart.fill")
    //let image = Image("❤️")
    var particles = Set<Particle>()
    var center = UnitPoint.center
    var hue = 0.0

    
    @MainActor
    func update(date: TimeInterval) async {
    
        let deathDate = date - 1

        let numberOfParticles = 999999
        let particleRange: ClosedRange  = 0...numberOfParticles
     
          for _ in particleRange {
              for particle in particles {
                  
                  if particle.creationDate > deathDate{
                    particles.remove(particle)
                  }
              }
              let newParticle = Particle(x: center.x, y: center.y, hue: hue)
            particles.insert(newParticle)
            //hue += 0.01
            
            if hue < 0 { hue -= 1 }
        }
    }
}
