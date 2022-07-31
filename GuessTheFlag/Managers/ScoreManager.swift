import UIKit

final class ScoreManager {

    public static let shared = ScoreManager()

    public var bestScore: Int { UserDefaults.standard.value(forKey: "bestScore") as? Int ?? 0 }

    public var score: Int {
        didSet {
            if score > bestScore {
                UserDefaults.standard.setValue(score, forKey: "bestScore")
            }
        }
    }
    
    init (score: Int = 0) {
        self.score = score
    }
}
