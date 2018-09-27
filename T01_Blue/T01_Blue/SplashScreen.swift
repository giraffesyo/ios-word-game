//
//  SplashScreen.swift
//  T01_Blue
//
//  Created by Joshua B McMahan on 9/22/18.
//  Copyright © 2018 Team Blue. All rights reserved.
//

import UIKit
import AVFoundation

class SplashScreen: UIViewController {
    var themeAudioPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // theme song audio
        guard let audioSourceURL = Bundle.main.url(forResource: "theme", withExtension: "wav")else{
            print("cannot find audio file")
            return
        }
        
        do{
            themeAudioPlayer = try AVAudioPlayer(contentsOf: audioSourceURL)
            
            // buffer the audio player
            themeAudioPlayer.prepareToPlay()
        }
        catch{
            print("cannot create audio player")
            print(error)
        }
        //has the audio loop indefinitely until the start button is pressed
        themeAudioPlayer.numberOfLoops = -1
        
        // play audio when loaded
        themeAudioPlayer.play()
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        performSegue(withIdentifier: "startGame", sender: self)
        themeAudioPlayer.stop()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
