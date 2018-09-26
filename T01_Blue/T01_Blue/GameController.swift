//  ViewController.swift
//  T01_Blue

import UIKit
import AVFoundation

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
    @IBOutlet var PlayAgainButton: UIButton!
<<<<<<< HEAD
    @IBOutlet weak var Hint: UILabel!

=======
>>>>>>> 3ac6121a5d37e274483d3eaaf9907c0d2ff16b83
    var audioPlayer: AVAudioPlayer! //add audio player
    
    //class variables
    let points:[Int] = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 20, 20, 20, 20, 20, 20, 30, 30, 30, 30, 30, 40, 40, 40, 50, 50, 50, 100, 100, 250, 500]
    let words: [String] = ["Banana", "Busy", "Laptop", "Catdog", "Catnip", "Pizza", "Monster", "Energy", "Macbook", "iPhone", "Park", "Family", "Join", "About", "Visit", "Class", "Heater", "Mouse", "Debut", "Donkey", "Printer", "Glass", "Bottle", "Hoodie", "Shoes", "Socks", "Pajamas", "Pillow", "Sleep", "Soccer", "github", "steam", "apple", "swift", "java", "android", "linux", "alarm", "paper", "string", "drink", "puzzle", "cable", "tires", "rotor", "motor", "machine", "kellogs", "general"]
    let hints: [String] = ["Fruit", "Workload", "Portable technology", "Animated cartoon show", "Herb", "Food", "Scary", "RedBull", "Computer", "Phone", "Play", "Joint or nuclear", "Connection", "Near", "Meet", "School", "Hot", "Computer Hardware", "Launch", "Animal", "Hard Copy", "Fragile", "Water", "Clothes", "Footwear", "Footwear", "Clothes", "Bed", "Bed", "Game", "Software development platform", "Hot", "Fruit", "Language", "Language", "Phone", "Operating system", "Wake-up", "Pen-pencil", "Sentences", "Water", "Game", "Wire", "Car", "Palindrome", "Machine", "Saves time", "Breakfast", "Common"]
    var animatedLever: UIImage = #imageLiteral(resourceName: "frame_00_delay-2s")
    var chosenWord: String = ""
    var boxes: [LetterBox] = []
    var revealsRemaining: Int = 0
    var currentPointValue: Int = 0
    var guessesReamining: Int = 0
    var score = 0
    var index = 0
    
    //create array of images to animate the lever
    let LeverImages = [#imageLiteral(resourceName: "frame_00_delay-2s"),#imageLiteral(resourceName: "frame_01_delay-0.05s"),#imageLiteral(resourceName: "frame_02_delay-0.04s"),#imageLiteral(resourceName: "frame_03_delay-0.03s"),#imageLiteral(resourceName: "frame_04_delay-0.02s"),#imageLiteral(resourceName: "frame_05_delay-0.02s"),#imageLiteral(resourceName: "frame_06_delay-0.02s"),#imageLiteral(resourceName: "frame_07_delay-0.02s"),#imageLiteral(resourceName: "frame_08_delay-0.02s")]
    
    //create array of images to animate the lever
    let LeverImages = [#imageLiteral(resourceName: "frame_00_delay-2s"),#imageLiteral(resourceName: "frame_01_delay-0.05s"),#imageLiteral(resourceName: "frame_02_delay-0.04s"),#imageLiteral(resourceName: "frame_03_delay-0.03s"),#imageLiteral(resourceName: "frame_04_delay-0.02s"),#imageLiteral(resourceName: "frame_05_delay-0.02s"),#imageLiteral(resourceName: "frame_06_delay-0.02s"),#imageLiteral(resourceName: "frame_07_delay-0.02s"),#imageLiteral(resourceName: "frame_08_delay-0.02s")]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let audioSourceURL = Bundle.main.url(forResource: "wheelsound2", withExtension: "wav")
            else {
                print("can not find audio")
                return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioSourceURL)
            
            //buffer the audio so that it wont pause
            audioPlayer.prepareToPlay()
        } catch {
            print("no audio")
            print("error")
        }

        
        SolutionTextField.delegate = self
        self.newGame()
    }
    
    func setRevealsRemaining(amount: Int) {
        self.revealsRemaining = amount
        self.RevealsRemainingLabel.text = "Reveals Remaining: \(self.revealsRemaining)"
    }
    
    func decrementRevealsReamining() {
        self.setRevealsRemaining(amount: self.revealsRemaining - 1)
        self.showHint(amount: self.revealsRemaining, index: index)
    }
    
    func setScore(amount: Int) {
        self.score = amount
        self.scoreDisplay.text = "Score: \(self.score)"
    }
    
    func incrementScore(by: Int) {
        setScore(amount: self.score + by)
    }
    
    func showHint(amount: Int, index: Int){
        print("func showHint() 1")
        if amount < 2
        {
            self.Hint.isHidden = false
            self.Hint.text = "Hint: \(hints[index])"
            print ("Hint.text: \(Hint.text!)")
        }
        print("func showHint() 2")

    }
    
    // Called whenever the lever is pressed, starting off the process of randomly getting a point value, and then choosing a letter
    @IBAction func leverPressed(_ sender: UIButton) {
        //clear out all boxes
        emptyBoxes()
        //give them two reveals and 3 guesses
        setRevealsRemaining(amount: 2)
        resetStrikes()
        
        //show the reveals remaining label
        RevealsRemainingLabel.isHidden = false
        
        if let leverImageView = leverButton.imageView {
            leverImageView.animationImages = LeverImages
            leverImageView.animationDuration = 1
            leverImageView.animationRepeatCount = 0
            leverImageView.startAnimating()
            self.audioPlayer.play()
    
            
        } else {
            //couldnt unwrap we'll just proceed with text
            leverButton.titleLabel!.text = "Pull this!"
        }
        animatedLever = UIImage.animatedImage(with: LeverImages, duration: 1)!
        //start the animation
        
        //get a random value that will be awarded if they get it right
        currentPointValue = points.randomElement()!
        //animate the value changing a bunch
        let wheelTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {timer in
            self.pointsDisplay.text =  String(self.points.randomElement()!)
        })
        //hide lever 1 second after it's pulled, instead put a solve button
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { thistimer in
            self.leverButton.isHidden = true
            self.solveButton.isHidden = false
            self.SolutionTextField.isHidden = false
            self.leverButton.imageView?.stopAnimating()
            
            
            //invalidate wheel animation timer (changing numbers animation)
            wheelTimer.invalidate()
            //invalidate myself
            thistimer.invalidate()
            // set point display to the real point value
            self.updatePointDisplay()
        })
        // if we change this to get an array from the internet we should do a
        // real nil check here
        //Chose a random word from the array of words
        
        chosenWord = words.randomElement()!
        index = words.index(of: chosenWord)!
        //showHint(amount: 2, index: index)
       
        // print the word in the debug console so we know what it is
        print(chosenWord)
        
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
            self.decrementRevealsReamining()
            //self.showHint(amount: 2, index: index)
            print ("showHint() done")

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
            let scoreToAward = currentPointValue + currentPointValue * revealsRemaining
            incrementScore(by: scoreToAward)
            transitionToLever()
            //reset the solution text box
            SolutionTextField.text = ""
        } else {
            //the user is wrong, take away one life
            removeLife()
        }
    }
    
    func transitionToLever() {
        //hide solve stuff
        self.SolutionTextField.isHidden = true
        self.solveButton.isHidden = true
        self.Hint.isHidden = true
        //show the lever
        self.leverButton.isHidden = false
        //reset strikes to hidden
        self.resetStrikes()
        //hide reveals remaining label
        self.RevealsRemainingLabel.isHidden = true
        //reveal the boxes
        self.revealAll()
    }
    
    func resetStrikes() {
        self.guessesReamining = 3
        strikeOne.isHidden = true
        strikeTwo.isHidden = true
        strikeThree.isHidden = true
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
        self.PlayAgainButton.isHidden = false
        
    }
    @IBAction func PlayAgainButtonPressed(_ sender: UIButton) {
        //start a new game
        newGame()
        
    }
    
    //reset everything
    func newGame() {
        //reset solutiontext box
        SolutionTextField.text = ""
        //hide play again button
        PlayAgainButton.isHidden = true
        //unhide lever
        leverButton.isHidden = false
        //hide hint
        Hint.isHidden = true
        // reset score and reveals remaining
        setRevealsRemaining(amount: 2)
        setScore(amount: 0)
        //hide strikes
        resetStrikes()
        //hide solve button
        solveButton.isHidden = true
        //hide solution text field
        SolutionTextField.isHidden = true
        //remove all the boxes
        emptyBoxes()
    }
}
