import Foundation
import UIKit

// Delays code execution - somehow...
public func delay(seconds seconds: Double, completion:() -> ()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_MSEC) * seconds))
    
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
        completion()
    }
}

public func random(min min: CGFloat, max: CGFloat) -> CGFloat {
    return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF)) * (max - min) + min
}

