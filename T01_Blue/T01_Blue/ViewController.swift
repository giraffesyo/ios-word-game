//
//  ViewController.swift
//  T01_Blue
//
//  Created by Josh Sheridan on 9/11/18.
//  Copyright © 2018 Josh Sheridan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Outlets
    @IBOutlet weak var scoreDisplay: UILabel! //score above the puzzle
    @IBOutlet weak var strikeOne: UILabel! //first X
    @IBOutlet weak var strikeTwo: UILabel! //second X
    @IBOutlet weak var strikeThree: UILabel! //third X
    @IBOutlet weak var pointsDisplay: UILabel! //points in the selector box
    @IBOutlet weak var oneOne: UIImageView! //row one, index one
    @IBOutlet weak var oneTwo: UIImageView! //row one, index two
    @IBOutlet weak var twoOne: UIImageView! //row two, index one
    @IBOutlet weak var twoTwo: UIImageView! //row two, index two
    @IBOutlet weak var twoThree: UIImageView! //row two, index three
    @IBOutlet weak var twoFour: UIImageView! //row two, index four
    @IBOutlet weak var twoFive: UIImageView! //row two, index five
    
    //class variables
    let points:[Int] = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 20, 20, 20, 20, 20, 20, 30, 30, 30, 30, 30, 40, 40, 40, 50, 50, 50, 100, 100, 250, 500]
    let words: [String] = ["Banana","Busy","Laptop"]
    var chosenWord: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strikeOne.isHidden = true
        strikeTwo.isHidden = true
        strikeThree.isHidden = true
    }

    // Called whenever the lever is pressed, starting off the process of randomly getting a point value, and then choosing a letter
    @IBAction func leverPressed(_ sender: UIButton) {
        let selectedPoint = points.randomElement()!
        pointsDisplay.text =  String(selectedPoint)
        // if we change this to get an array from the internet we should do a
        // real nil check here
        chosenWord = words.randomElement()!
        print("Word chosen was: " + chosenWord + " Point value is: " + String(selectedPoint))
        
        
        //figure out how to have keyboard pop up for user entry. Store user entered letter
    }
    
    //create function to check if keyboard entry matches any of the puzzle pieces
    
}

