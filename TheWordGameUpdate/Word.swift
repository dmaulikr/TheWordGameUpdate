//
//  Word.swift
//  TheWordGameUpdate
//
//  Created by Cowboy Lynk on 8/27/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class Word: UIView {
    
    var letters: [Tile] = [Tile]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    // TURN TYPES: (-1: init), (0: add), (1: rem.), (2: swap), (3: rearr.)
    func updateVisuals(turnType: Int, index: Int){
        let numLetters = Double(letters.count)
        var currentDimension = Double(self.frame.width)/(1.1*numLetters - 0.1)
        var xCenter = 0.0
        
        
        // Alternates between the default dimension and the scaled dimension
        if numLetters < 4 {
            currentDimension = Double(self.frame.width)/(1.1*4 - 0.1)
            xCenter += Double(4 - letters.count)*currentDimension*1.1/2.0
        } else {
            
        }
        
        // Adjusts the point so that its at the center and not on the left edge
        xCenter += currentDimension/2.0
        let scaleDimension = currentDimension/Double(letters[index].defaultDimension)  // A decimal value e.g. 0.8
        
        // Puts the new tile in the right position for when its added in
        if turnType == 0 || turnType == 2 {
            letters[index].center.x = CGFloat(xCenter + Double(index)*currentDimension*1.1)
        }
        
        UIView.animate(withDuration: 0.7) {
            // Cycles through each of the letters in the word
            for i in 0..<self.letters.count {
                let letter = self.letters[i]
                
                letter.alpha = 1
                letter.transform = CGAffineTransform(scaleX: CGFloat(scaleDimension), y: CGFloat(scaleDimension))
                letter.center = CGPoint(x: xCenter, y: 50)
                
                if i != index{
                    letter.removeIndicator()
                }
                
                xCenter += currentDimension*1.1
            }
        }
    }
    
    func addLetter(letter: String, index: Int){
        if index <= letters.count {
            let newLetter = Tile(letter: letter)
            newLetter.addIndicator()
            letters.insert(newLetter, at: index)
            self.addSubview(newLetter)
        }
        updateVisuals(turnType: 0, index: index)
    }
    
    func removeLetter(index: Int){
        if index < letters.count {
            letters.remove(at: index)
        }
        updateVisuals(turnType: 1, index: index)
    }
    
    func swapLetter(letter: String, index: Int) {
        
    }
    
    func rearrangeLetters(newWord: String){
        
    }
    
    
}
