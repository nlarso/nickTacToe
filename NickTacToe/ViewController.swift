//
//  ViewController.swift
//  NickTacToe
//
//  Created by robotNik on 8/22/14.
//  Copyright (c) 2014 robotNik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet var ticTacImg1: UIImageView!
    @IBOutlet var ticTacImg2: UIImageView!
    @IBOutlet var ticTacImg3: UIImageView!
    @IBOutlet var ticTacImg4: UIImageView!
    @IBOutlet var ticTacImg5: UIImageView!
    @IBOutlet var ticTacImg6: UIImageView!
    @IBOutlet var ticTacImg7: UIImageView!
    @IBOutlet var ticTacImg8: UIImageView!
    @IBOutlet var ticTacImg9: UIImageView!
    
    
    @IBOutlet var ticTacBtn1: UIButton!
    @IBOutlet var ticTacBtn2: UIButton!
    @IBOutlet var ticTacBtn3: UIButton!
    @IBOutlet var ticTacBtn4: UIButton!
    @IBOutlet var ticTacBtn5: UIButton!
    @IBOutlet var ticTacBtn6: UIButton!
    @IBOutlet var ticTacBtn7: UIButton!
    @IBOutlet var ticTacBtn8: UIButton!
    @IBOutlet var ticTacBtn9: UIButton!
    
    @IBOutlet var resetBtn: UIButton!
    @IBOutlet var userMessage: UILabel!
    
    var plays = [Int:Int]()
    var done : Bool = false
    var aiDeciding : Bool = false
    
    
    @IBAction func UIButtonClicked(sender:UIButton) {
        userMessage.hidden = true
        if (plays[sender.tag] == nil) && !aiDeciding && !done {
            setImageForSquare(sender.tag, player:1)
        }
        checkForWin()
        aiTurn()
    }
    
    internal func setImageForSquare(spot:Int,player:Int) {
        var playerMark = player == 1 ? "ex" : "oh"
        plays[spot] = player
        switch spot {
        case 1:
            ticTacImg1.image = UIImage(named: playerMark)
        case 2:
            ticTacImg2.image = UIImage(named: playerMark)
        case 3:
            ticTacImg3.image = UIImage(named: playerMark)
        case 4:
            ticTacImg4.image = UIImage(named: playerMark)
        case 5:
            ticTacImg5.image = UIImage(named: playerMark)
        case 6:
            ticTacImg6.image = UIImage(named: playerMark)
        case 7:
            ticTacImg7.image = UIImage(named: playerMark)
        case 8:
            ticTacImg8.image = UIImage(named: playerMark)
        case 9:
            ticTacImg9.image = UIImage(named: playerMark)
        default:
            ticTacImg9.image = UIImage(named: playerMark)
        }
    }
    
    @IBAction func resetBtnClicked(sender:UIButton) {
        done = false
        resetBtn.hidden = true
        userMessage.hidden = true
        reset()
    }

    func reset() {
        plays = [:]
        ticTacImg1.image = nil
        ticTacImg2.image = nil
        ticTacImg3.image = nil
        ticTacImg4.image = nil
        ticTacImg5.image = nil
        ticTacImg6.image = nil
        ticTacImg7.image = nil
        ticTacImg8.image = nil
        ticTacImg9.image = nil
    }
    
    func checkForWin() {
        var whoWon = ["I":0, "You":1]
        var winner = false
        for(key,value) in whoWon {
            //  #TODO Refactor this method - The if statement below severely broke after updating to Xcode Beta 6 with the following errors:
            //  Cannot invoke '&&' with an argument list of type '($T78, $T84)'
            //  Expression was too complex to be solved in reasonable time; consider breaking up the expression into distinct sub-expressions
            if winner == false {
                if (plays[1] == value && plays[2] == value && plays[3] == value) {
                    winner = true
                } else if (plays[4] == value && plays[5] == value && plays[6] == value) {
                    winner = true
                } else if (plays[7] == value && plays[8] == value && plays[9] == value) {
                    winner = true
                } else if (plays[1] == value && plays[4] == value && plays[7] == value) {
                    winner = true
                } else if (plays[2] == value && plays[5] == value && plays[8] == value) {
                    winner = true
                } else if (plays[3] == value && plays[6] == value && plays[9] == value) {
                    winner = true
                } else if (plays[1] == value && plays[5] == value && plays[9] == value) {
                    winner = true
                } else if (plays[3] == value && plays[5] == value && plays[7] == value) {
                    winner = true
                }
            }
            if winner == true {
                userMessage.hidden = false
                userMessage.text = "Looks like \(key) won!"
                resetBtn.hidden = false
                done = true
                return
            }
        }
        
    }

    func checkFor(value:Int, inList:[Int]) -> String {
        var conclusion = ""
        for cell in inList {
            if plays[cell] == value {
                conclusion += "1"
            }else{
                conclusion += "0"
            }
        }
        return conclusion
    }

    func rowCheck(#value:Int) -> (location:String, pattern:String)? {
        var acceptableFinds = ["011", "110", "101"]
        var possiblePatterns = ["top":[1,2,3], "bottom":[7,8,9], "left":[1,4,7], "right":[3,6,9], "middleHorizontal":[4,5,6], "middleVertical":[2,5,8], "diagLeftRight":[1,5,9], "diagRightLeft":[7,5,3]]
        for(k,v) in possiblePatterns {
            var result = checkFor(value, inList: v)
            if contains(acceptableFinds, result) {
                return (k, result)
            }
        }
        return nil
    }
    
    func isOccupied(spot:Int) -> Bool {
        return (plays[spot] != nil)
    }
    
    func firstAvailable(#isCorner:Bool) -> Int? {
        var spots = isCorner ? [1,3,7,9] : [2,4,6,8]
        for spot in spots {
            if !isOccupied(spot) {
                return spot
            }
        }
        return nil
    }
    
    func whereToPlay(location:String, pattern:String) -> Int {
        var leftPattern = "011"
        var rightPattern = "110"
        var middlePattern = "101"
        switch location {
        case "top":
            if pattern == leftPattern{
                return 1
            }else if pattern == rightPattern{
                return 3
            }else {
                return 2
            }
        case "bottom":
            if pattern == leftPattern {
                return 7
            }else if pattern == rightPattern{
                return 9
            }else{
                return 8
            }
        case "left":
            if pattern == leftPattern {
                return 1
            }else if pattern == rightPattern{
                return 7
            }else{
                return 4
            }
        case "right":
            if pattern == leftPattern {
                return 3
            }else if pattern == rightPattern{
                return 9
            }else{
                return 6
            }
        case "middleVertical":
            if pattern == leftPattern {
                return 2
            }else if pattern == rightPattern{
                return 8
            }else{
                return 5
            }
        case "middleHorizontal":
            if pattern == leftPattern {
                return 4
            }else if pattern == rightPattern{
                return 6
            }else{
                return 5
            }
        case "diagLeftRight":
            if pattern == leftPattern {
                return 1
            }else if pattern == rightPattern{
                return 9
            }else{
                return 5
            }
        case "diagRightLeft":
            if pattern == leftPattern {
                return 3
            }else if pattern == rightPattern{
                return 7
            }else{
                return 5
            }
        default:
            return 4
        }
    }

    
    func aiTurn() {
        if done == true {
            return
        }
        
        var aiDeciding = true
        
        //check if AI has 2 in a row
        if let result = rowCheck(value:0){
            var whereToPlayResult = whereToPlay(result.location, pattern: result.pattern)
            if !isOccupied(whereToPlayResult) {
                setImageForSquare(whereToPlayResult, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
        }
        
        //check if Player has 2 in a row
        if let result = rowCheck(value:1) {
            var whereToPlayResult = whereToPlay(result.location,pattern: result.pattern)
            if !isOccupied(whereToPlayResult) {
                setImageForSquare(whereToPlayResult, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
        }
        
        //Check if center position is available
        if !isOccupied(5) {
            setImageForSquare(5, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        if let cornerAvailable = firstAvailable(isCorner: true) {
            setImageForSquare(cornerAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        if let sideAvailable = firstAvailable(isCorner: false) {
            setImageForSquare(sideAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        userMessage.hidden = false
        userMessage.text = "It's a tie! Looks like the cat got the game"
        resetBtn.hidden = false
        done = true
        aiDeciding = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

