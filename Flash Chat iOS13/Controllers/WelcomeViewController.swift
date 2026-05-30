//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    let titleText = "⚡️FlashChat"
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateTitle()
    }
    
    func animateTitle(){
        titleLabel.text = titleText
//        var counter = 0
//        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
//            let index = self.titleText.index(self.titleText.startIndex, offsetBy: counter)
//            let newLetter = self.titleText[index]
//
//            self.titleLabel.text?.append(newLetter)
//            counter += 1
//            if counter >= self.titleText.count {
//                timer.invalidate()
//            }
//        }
        
    }
}
