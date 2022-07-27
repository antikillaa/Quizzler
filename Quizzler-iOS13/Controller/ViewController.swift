import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var progressBarr: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    

    var quizBrain = QuizBrain()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBarr.progress = 0
        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle?.lowercased()
        let correctAnswer = quizBrain.checkAnswer(userAnswer!)
        
        if correctAnswer {
            sender.backgroundColor = .green
            print("Right")
        } else {
            sender.backgroundColor = .red

            print("Wrong")
        }
    
        progressBarr.progress = quizBrain.getProgress()
        
        let nextQuestion = quizBrain.nextQuestion()
        
        if nextQuestion {
            Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        } else {
            updateUI()
            questionLabel.text = "Your score is: \(quizBrain.getScore())"
            progressBarr.progress = 1
            trueButton.isEnabled = false
            falseButton.isEnabled = false
            tryAgainButton.isHidden = false
            tryAgainButton.isEnabled = true
        }
        
    }

    @IBAction func tryAgain(_ sender: UIButton) {
        resetGame()
    }
    
    @objc func updateUI() {
        scoreLabel.text = "Score \(quizBrain.getScore())" 
        trueButton.backgroundColor = .clear
        falseButton.backgroundColor = .clear
        
        progressBarr.progress = quizBrain.getProgress()
        questionLabel.text = quizBrain.getQuestionText()
    }
    
    func resetGame() {
        tryAgainButton.isHidden = true
//        quizBrain.resetScore()
        trueButton.isEnabled = true
        falseButton.isEnabled = true
        progressBarr.progress = 0
        updateUI()
    }
 
}

