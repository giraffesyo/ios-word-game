//  ViewController.swift
//  T01_Blue

import UIKit

class ViewController: UIViewController {
    // Outlets
    @IBOutlet weak var scoreDisplay: UILabel! //score above the puzzle
    @IBOutlet weak var strikeOne: UILabel! //first X
    @IBOutlet weak var strikeTwo: UILabel! //second X
    @IBOutlet weak var strikeThree: UILabel! //third X
    @IBOutlet weak var pointsDisplay: UILabel! //points in the selector box
    
    //class variables
    let points:[Int] = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 20, 20, 20, 20, 20, 20, 30, 30, 30, 30, 30, 40, 40, 40, 50, 50, 50, 100, 100, 250, 500]
    let words: [String] = ["Banana","Busy","Laptop"]
    var chosenWord: String = ""
    var boxes: [LetterBox] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strikeOne.isHidden = true
        strikeTwo.isHidden = true
        strikeThree.isHidden = true
    }
    
    @IBOutlet var BoxesStackView: UIStackView!
    // Called whenever the lever is pressed, starting off the process of randomly getting a point value, and then choosing a letter
    @IBAction func leverPressed(_ sender: UIButton) {
        emptyBoxes()
        let selectedPointValue = points.randomElement()!
        let timer1 = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {timer in
            self.pointsDisplay.text =  String(self.points.randomElement()!)
            
        })
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            timer1.invalidate()
            
            self.pointsDisplay.text = String(selectedPointValue)
            })
        print(selectedPointValue)
        // if we change this to get an array from the internet we should do a
        // real nil check here
        //Chose a random word from the array of words
        chosenWord = words.randomElement()!
        // Add boxes with letters (initially hidden letters) to the
        // user interface
        
        for letter in chosenWord {
            // Create a box instance for every letter of the word
            let box: LetterBox = LetterBox(letter: letter)
            // Enable user interaction on each box
            box.IMAGEVIEW.isUserInteractionEnabled = true
            // Create gesture recognizer
            // Reference https://guides.codepath.com/ios/Using-Gesture-Recognizers for programmatically adding gesture recognizers
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapBoxHandler(sender: )))
            //Give the tapGestureRecognizer a name so we can check it later
            tapGestureRecognizer.name = String(box.LETTER)
            // Add gesture recognizer
            box.IMAGEVIEW.addGestureRecognizer(tapGestureRecognizer)
            // Add the box to array of boxes
            boxes.append(box)
            // Add the box's imageview to the horizontal stack view
            BoxesStackView.addArrangedSubview(box.IMAGEVIEW)
            
        }
        
        //figure out how to have keyboard pop up for user entry. Store user entered letter
    }
    
    //Handle taps in the boxes
    @objc func tapBoxHandler(sender: UITapGestureRecognizer){
        //The letter is stored in sender.name
        let letterTapped: Character = Character(sender.name!)
        
        revealLetters(letter: letterTapped)
    }
    
    func revealLetters(letter: Character) {
        var i: Int = 0
        repeat {
            if boxes[i].LETTER == letter{
                print(boxes[i].LETTER)
                boxes[i].reveal()
                
            }
            i = i + 1
        }while i < boxes.count
        
    }
    
    
    //Remove all boxes, if they exist.
    private func emptyBoxes() {
        if self.boxes.count != 0 {
            for box in self.boxes {
                BoxesStackView.removeArrangedSubview(box.IMAGEVIEW)
                box.IMAGEVIEW.removeFromSuperview()
            }
            
            boxes = []
        }
    }
    
    
    //create function to check if keyboard entry matches any of the puzzle pieces
    
}
