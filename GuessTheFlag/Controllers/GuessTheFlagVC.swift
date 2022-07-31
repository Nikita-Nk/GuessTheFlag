import UIKit
import SnapKit

class GuessTheFlagVC: UIViewController {
    
    private let topButton = UIButton()
    private let middleButton = UIButton()
    private let bottomButton = UIButton()
    lazy var buttons: [UIButton] = [topButton, middleButton, bottomButton]
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons(buttons: buttons)
        view.addSubviews(topButton, middleButton, bottomButton)
        newFlag()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topButton.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width / 4 * 3)
            make.height.equalTo(view.frame.width / 8 * 3)
            make.centerX.equalToSuperview()
            make.topMargin.equalToSuperview().inset(50)
        }
        middleButton.snp.makeConstraints { make in
            make.size.equalTo(topButton)
            make.centerX.equalToSuperview()
            make.top.equalTo(topButton.snp.bottom).offset(25)
        }
        bottomButton.snp.makeConstraints { make in
            make.size.equalTo(middleButton)
            make.centerX.equalToSuperview()
            make.top.equalTo(middleButton.snp.bottom).offset(25)
        }
    }
    
    //MARK: - Private
    
    private func setupButtons(buttons: [UIButton]) {
        for (index, button) in buttons.enumerated() {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.imageView?.contentMode = .scaleToFill
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            button.tag = index
        }
    }
    
    @objc private func buttonTapped(button: UIButton!) {
        var alertTitle: String
        
        if button.tag == FlagsManager.shared.correctAnswer {
            alertTitle = "Correct"
            ScoreManager.shared.score += 1
            HapticsManager.shared.vibrate(for: .success)
        } else {
            alertTitle = "Wrong"
            ScoreManager.shared.score -= 1
            HapticsManager.shared.vibrate(for: .error)
        }
        
        newFlag()
        
        let alertController = UIAlertController(title: alertTitle, message: "Your score is \(ScoreManager.shared.score). \nBest score is \(ScoreManager.shared.bestScore)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    private func newFlag() {
        FlagsManager.shared.newFlags { flagUrls, title in
            for (index, button) in self.buttons.enumerated() {
                button.sd_setImage(with: flagUrls[index], for: .normal, completed: nil)
            }
            self.title = title
        }
    }
}
