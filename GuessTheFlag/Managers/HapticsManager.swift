import UIKit

final class HapticsManager {
    
    public static let shared = HapticsManager()
    
    private init() {}
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}

