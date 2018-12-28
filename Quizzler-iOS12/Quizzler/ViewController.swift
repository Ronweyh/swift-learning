//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var curQuestionIndex = 0
    var currentQuestion: Question!
    var score : Int = 0
    var rightCount: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestion = allQuestions.list[curQuestionIndex]
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else {
            pickedAnswer = false
        }
        
        checkAnswer()
    }
    
    
    func updateUI() {
        questionLabel.text = currentQuestion.questionText
        scoreLabel.text = "\(score)"
        progressLabel.text = "\(curQuestionIndex + 1)/\(allQuestions.list.count)"
    }
    

    func nextQuestion() {
        if curQuestionIndex < allQuestions.list.count - 1 {
            curQuestionIndex += 1
            currentQuestion = allQuestions.list[curQuestionIndex]
            updateUI()
        } else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {
                (UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[curQuestionIndex].answer
        if correctAnswer == pickedAnswer {
            print("you got it")
            score += 10
            rightCount += 1
        } else {
            print("you choose wrong answer")
        }
        nextQuestion()
    }
    
    
    func startOver() {
        curQuestionIndex = -1
        score = 0
        nextQuestion()
    }
    

    
}
