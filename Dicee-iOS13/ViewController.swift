//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imageArray = [
        UIImage(named: "DiceOne"),
        UIImage(named: "DiceTwo"),
        UIImage(named: "DiceThree"),
        UIImage(named: "DiceFour"),
        UIImage(named: "DiceFive"),
        UIImage(named: "DiceSix")
    ]
    
    let rollQueue = DispatchQueue(label: "rollQueue")
    
    let backgroundView: UIImageView = {
        let image = UIImage(named: "GreenBackground")
        let imageView = UIImageView(image: image)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let diceLogo: UIImageView = {
        let image = UIImage(named: "DiceeLogo")
        let imageView = UIImageView(image: image)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var leftDice: UIImageView = {
        let image = UIImage(named: "DiceOne")
        let imageView = UIImageView(image: image)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var rightDice: UIImageView = {
        let image = UIImage(named: "DiceTwo")
        let imageView = UIImageView(image: image)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let rollButton: UIButton = {
        let button = UIButton()
        button.setTitle("Roll", for: .normal)
        button.setTitle("Rolling...", for: .disabled)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.backgroundColor = #colorLiteral(red: 0.6064250469, green: 0.1083366945, blue: 0.1235839948, alpha: 1)
        
        button.addTarget(self, action: #selector(rollDice(sender:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializaComponents()
    }
    
    private func initializaComponents() {
        view.addSubview(backgroundView)
        view.addSubview(diceLogo)
        view.addSubview(leftDice)
        view.addSubview(rightDice)
        view.addSubview(rollButton)
        
        let backgroundConstraints = [
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        let logoConstraints = [
            diceLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diceLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ]
        
        let leftDiceConstraints = [
            leftDice.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leftDice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            leftDice.widthAnchor.constraint(equalToConstant: 120),
            leftDice.heightAnchor.constraint(equalToConstant: 120)
        ]
        
        let rightDiceConstraints = [
            rightDice.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rightDice.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            rightDice.widthAnchor.constraint(equalToConstant: 120),
            rightDice.heightAnchor.constraint(equalToConstant: 120)
        ]
        
        let rollButtonConstraints = [
            rollButton.topAnchor.constraint(equalTo: leftDice.bottomAnchor, constant: 90),
            rollButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rollButton.widthAnchor.constraint(equalToConstant: 170),
            rollButton.heightAnchor.constraint(equalToConstant: 70)
        ]
        
        NSLayoutConstraint.activate(
            backgroundConstraints
            + logoConstraints
            + leftDiceConstraints
            + rightDiceConstraints
            + rollButtonConstraints
        )
    }
    
    @objc func rollDice(sender: UIButton!) {
        
        rollButton.isEnabled = false
        rollButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        rollQueue.async {
            for _ in 1...25 {
                DispatchQueue.main.async { [weak self] in
                    self?.leftDice.image = self?.imageArray[Int.random(in: 0..<6)]
                    self?.rightDice.image = self?.imageArray[Int.random(in: 0..<6)]
                }
                usleep(100000)
            }
            DispatchQueue.main.async { [weak self] in
                self?.rollButton.isEnabled = true
                self?.rollButton.backgroundColor = #colorLiteral(red: 0.6064250469, green: 0.1083366945, blue: 0.1235839948, alpha: 1)
            }
        }
    }
}

