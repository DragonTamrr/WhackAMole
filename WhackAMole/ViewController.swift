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
    let lostLabel = UILabel.init()
    let highScoreLabel = UILabel.init()
    var screenSize = UIScreen.main.bounds
    var score = 0
    var highScore = 0
    var repeatTimer = true
    var firstPress = true
    var timer = Timer.init()
    var isLandscape = UIDevice.current.orientation.isLandscape
    
    override func viewDidLoad() {
        let view = UIView()
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        scoreLabel.frame = CGRect(x: 10, y: 15, width: 100, height: 50)
        lostLabel.frame = CGRect(x: screenSize.width / 2 - 95, y: screenSize.height / 2 - 100, width: 300, height: 50)
        highScoreLabel.frame = CGRect(x: screenSize.width / 2 - 50, y: 15, width: 200, height: 50)
        buttonToPress.frame = CGRect(x: screenSize.width / 2 - 50, y: screenSize.height / 2 - 25, width: 100, height: 50)
        
        screenSize = UIScreen.main.bounds
        highScoreLabel.attributedText = NSAttributedString(string: "High Score: \(highScore)")
        lostLabel.attributedText = NSAttributedString(string: "")
        scoreLabel.attributedText = NSAttributedString(string: "")
        
        lostLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        buttonToPress.setTitle("Tap to Start", for: .normal)
        buttonToPress.backgroundColor = UIColor(red: 0.37, green: 0.85, blue: 0.21, alpha: 1)
        buttonToPress.layer.cornerRadius = 10.0
        buttonToPress.addTarget(self, action: #selector(buttonAction(_:)), for: .touchDown)
        
        view.addSubview(buttonToPress)
        view.addSubview(scoreLabel)
        view.addSubview(lostLabel)
        view.addSubview(highScoreLabel)
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
        lostLabel.attributedText = NSAttributedString(string: "")
        timer.invalidate()
        buttonToPress.setTitle("Tap me", for: .normal)
        buttonToPress.frame = CGRect(x: Int.random(in : 100...Int(screenSize.width - 100)), y: Int.random(in : 50...Int(screenSize.height - 100)), width: 100, height: 50)
        
        if !firstPress {
            score += 1
            if score > highScore {
                highScore = score
                highScoreLabel.attributedText = NSAttributedString(string: "High Score: \(highScore)")
            }
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
        
        if score < 0{
            firstPress = true
            score = 0
            buttonToPress.frame = CGRect(x: screenSize.width / 2 - 50, y: screenSize.height / 2 - 25, width: 100, height: 50)
            lostLabel.attributedText = NSAttributedString(string: "You Lost! Tap to try again!")
            scoreLabel.attributedText = NSAttributedString(string: "")
            buttonToPress.setTitle("Tap to Start", for: .normal)
            timer.invalidate()
            
        }
    }
}

