//
//  LetterBox.swift
//  T01_Blue
//
//  Created by Michael McQuade on 9/20/18.
//  Copyright © 2018 Josh Sheridan. All rights reserved.
//

import UIKit

class LetterBox: NSObject {
    private let BOXIMAGE: UIImage = #imageLiteral(resourceName: "blank")
    private let LETTERIMAGES: [UIImage] = [#imageLiteral(resourceName: "A"),#imageLiteral(resourceName: "B"),#imageLiteral(resourceName: "C"),#imageLiteral(resourceName: "D"),#imageLiteral(resourceName: "E"),#imageLiteral(resourceName: "F"),#imageLiteral(resourceName: "G"),#imageLiteral(resourceName: "H"),#imageLiteral(resourceName: "I"),#imageLiteral(resourceName: "J"),#imageLiteral(resourceName: "K"),#imageLiteral(resourceName: "L"),#imageLiteral(resourceName: "M"),#imageLiteral(resourceName: "N"),#imageLiteral(resourceName: "O"),#imageLiteral(resourceName: "P"),#imageLiteral(resourceName: "Q"),#imageLiteral(resourceName: "R"),#imageLiteral(resourceName: "S"),#imageLiteral(resourceName: "T"),#imageLiteral(resourceName: "U"),#imageLiteral(resourceName: "V"),#imageLiteral(resourceName: "W"),#imageLiteral(resourceName: "X"),#imageLiteral(resourceName: "Y"),#imageLiteral(resourceName: "Z")]
    let LETTER: Character
    var IMAGEVIEW: UIImageView
    
    
    init(letter: Character){
        self.LETTER = letter
        self.IMAGEVIEW = UIImageView(image: BOXIMAGE)
    }
    
    public func reveal() {
        let letter = String(self.LETTER).uppercased()
        self.IMAGEVIEW = UIImageView(image: LETTERIMAGES[Int(UnicodeScalar(letter)!.value) - 65])
    }
}
