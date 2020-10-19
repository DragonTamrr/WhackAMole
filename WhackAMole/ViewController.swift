//
//  ViewController.swift
//  WhackAMole
//
//  Created by Douglas, Parker J on 10/13/20.
//  Copyright © 2020 Douglas, Parker J. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    
    let buttonToPress = UIButton()
    let scoreLabel = UILabel.init()
    var screenSize = UIScreen.main.bounds
    var score = 0
    var repeatTimer = true
    var firstPress = true
    var timer = Timer.init()
    var isLandscape = UIDevice.current.orientation.isLandscape
    
    override func viewDidLoad() {
        let view = UIView()
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        scoreLabel.frame = CGRect(x: 10, y: 15, width: 100, height: 50)
        buttonToPress.frame = CGRect(x: screenSize.width / 2 - 50, y: screenSize.height / 2 - 25, width: 100, height: 50)
        
        screenSize = UIScreen.main.bounds
        scoreLabel.attributedText = NSAttributedString(string: "")
        
        buttonToPress.setTitle("Tap to Start", for: .normal)
        buttonToPress.backgroundColor = UIColor(red: 0.1, green: 1.0, blue: 0.0, alpha: 1)
        buttonToPress.layer.cornerRadius = 10.0
        buttonToPress.addTarget(self, action: #selector(buttonAction(_:)), for: .touchDown)
        
        view.addSubview(buttonToPress)
        view.addSubview(scoreLabel)
        self.view = view
        // Do any additional setup after loading the view.
        
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        screenSize = CGRect(x: 0,y: 0, width: size.width, height: size.height)
        if firstPress {
            buttonToPress.frame = CGRect(x: screenSize.width / 2 - 50, y: screenSize.height / 2 - 25, width: 100, height: 50)
        }
        else {
            tooSlow()
        }
    }
    
    
    @objc func buttonAction(_ sender:UIButton!) {
        print("Button tapped")
        timer.invalidate()
        buttonToPress.setTitle("Tap me", for: .normal)
        buttonToPress.frame = CGRect(x: Int.random(in : 100...Int(screenSize.width - 100)), y: Int.random(in : 50...Int(screenSize.height - 100)), width: 100, height: 50)
        
        if !firstPress {
            score += 1
        }
        else {
            firstPress = false
        }
        
        scoreLabel.attributedText = NSAttributedString(string: "Score: \(score)")
        
        
        timer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 0.75...2), repeats: true) {timer in
            self.tooSlow()
        }
        
    }
    
    func tooSlow() {
        buttonToPress.frame = CGRect(x: Int.random(in : 100...Int(screenSize.width - 100)), y: Int.random(in : 50...Int(screenSize.height - 50)), width: 100, height: 50)
        score -= 1
        scoreLabel.attributedText = NSAttributedString(string: "Score: \(score)")
    }
}

