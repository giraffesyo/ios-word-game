//
//  LetterBox.swift
//  T01_Blue
//
//  Created by Michael McQuade on 9/20/18.
//  Copyright © 2018 Josh Sheridan. All rights reserved.
//

import UIKit

class LetterBox: NSObject {
    private let BOXIMAGE = #imageLiteral(resourceName: "tile1_blank_67")
    let LETTER: Character
    let IMAGEVIEW: UIImageView
    
    init(letter: Character){
        self.LETTER = letter
        self.IMAGEVIEW = UIImageView(image: BOXIMAGE)
    }
    
}
