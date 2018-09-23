//  ViewController.swift
//  T01_Blue

import UIKit

class GameController : UIViewController, UITextFieldDelegate {
    // Outlets
    @IBOutlet var scoreDisplay: UILabel! //score above the puzzle
    @IBOutlet var strikeOne: UILabel! //first X
    @IBOutlet var strikeTwo: UILabel! //second X
    @IBOutlet var strikeThree: UILabel! //third X
    @IBOutlet var pointsDisplay: UILabel! //points in the selector box
    @IBOutlet var RevealsRemainingLabel: UILabel!
    @IBOutlet var solveButton: UIButton!
    @IBOutlet var leverButton: UIButton!
    @IBOutlet var BoxesStackView: UIStackView!
    @IBOutlet var SolutionTextField: UITextField!
    
    //class variables
    let points:[Int] = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 20, 20, 20, 20, 20, 20, 30, 30, 30, 30, 30, 40, 40, 40, 50, 50, 50, 100, 100, 250, 500]
    let words: [String] = ["Banana","Busy","Laptop"]
    var chosenWord: String = ""
    var boxes: [LetterBox] = []
    var revealsRemaining: Int = 0
    var currentPointValue: Int = 0
    var guessesReamining: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide elements that shouldn't be on screen at first
        strikeOne.isHidden = true
        strikeTwo.isHidden = true
        strikeThree.isHidden = true
        leverButton.isHidden = false
        solveButton.isHidden = true
        SolutionTextField.isHidden = true
        SolutionTextField.delegate = self
    }
    
    // Called whenever the lever is pressed, starting off the process of randomly getting a point value, and then choosing a letter
    @IBAction func leverPressed(_ sender: UIButton) {
        //clear out all boxes
        emptyBoxes()
        //give them two reveals and 3 guesses
        revealsRemaining = 2
        guessesReamining = 3
        
        //hide lever when it's pulled, instead put a solve button
        leverButton.isHidden = true
        solveButton.isHidden = false
        SolutionTextField.isHidden = false
        //get a random value that will be awarded if they get it right
        currentPointValue = points.randomElement()!
        //animate the value changing a bunch
        let timer1 = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {timer in
            self.pointsDisplay.text =  String(self.points.randomElement()!)
        })
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            timer1.invalidate()
            // set point display to the real point value
            self.updatePointDisplay()
        })
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
    }
    
    //Handle taps in the boxes
    @objc func tapBoxHandler(sender: UITapGestureRecognizer){
        //The letter is stored in sender.name
        let letterTapped: Character = Character(sender.name!)
        if revealsRemaining > 0{
            revealLetters(letter: letterTapped)
            self.revealsRemaining = self.revealsRemaining - 1
            self.RevealsRemainingLabel.text = "Reveals Remaining: " + String(self.revealsRemaining)
            self.updatePointDisplay()
        }
    }
    
    func revealLetters(letter: Character) {
        var i: Int = 0
        repeat {
            if boxes[i].LETTER == letter{
                boxes[i].reveal()
            }
            i = i + 1
        }while i < boxes.count
        
    }
    
    func revealAll() {
        for box in boxes {
            box.reveal()
        }
    }
    
    private func updatePointDisplay() {
        pointsDisplay.text = String(self.currentPointValue + self.currentPointValue * self.revealsRemaining)
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
    
    //hide the keyboard when they press return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        SolutionTextField.resignFirstResponder()
        return true
    }
    
    
    // Check if we got the right answer when the
    // solve button is pressed
    @IBAction func solveButtonPressed(_ sender: UIButton) {
        //if solution is empty or nil do nothing
        guard let solution = SolutionTextField.text, !solution.isEmpty else {
            return
        }
        //else we will check the answer
        if solution.lowercased() == self.chosenWord.lowercased() {
            //the user is correct, award the points
        } else {
            //the user is wrong, take away one life
            removeLife()
        }
    }
    
    func removeLife(){
        self.guessesReamining = self.guessesReamining - 1
        switch(self.guessesReamining){
        case 2:
            self.strikeOne.isHidden = false
            break
        case 1:
            self.strikeTwo.isHidden = false
            break
        default:
            self.strikeThree.isHidden = false
            //we have no more lives
            gameOver()
            break
        }
        self.SolutionTextField.text = ""
    }
    //if we've lost all our lives this is called
    func gameOver() {
        //reveal the word
        self.revealAll()
        self.SolutionTextField.isHidden = true
        self.solveButton.isHidden = true
        // Change reveals remaining behind the scenes
        // without updating its label
        // this way they can't tap on the boxes anymore
        // but the screen doesn't change its state
        self.revealsRemaining = 0
        
    }
}
