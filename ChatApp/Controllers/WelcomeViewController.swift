//
//  WelcomeViewController.swift
//  ChatApp
//
//  Created by Ayca Akman on 22.05.2023.
//

import UIKit
import CLTypingLabel
class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Welcome Chat App"
//        titleLabel.text = ""
//        var charIndex = 0.0
//        let titleText = "Welcome Chat App"
//        for letter in titleText {
//            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
//                self.titleLabel.text?.append(letter)
//            }
//            charIndex += 1
//        }
        // Do any additional setup after loading the view.
    }
    



}
