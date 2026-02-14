//
//  ResultsViewController.swift
//  Personality Quiz
//
//  Created by May Abdulla on 08/02/2026.
//

import UIKit

/// Displays the results of the personality quiz
class ResultsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    // MARK: - Properties
    
    /// Array of responses from the user
    var responses: [Answer]
    
    /// The quiz that was taken (for history tracking - Stretch Goal 4)
    var selectedQuiz: Quiz?
    
    /// Time taken to complete the quiz (for history - Stretch Goal 5)
    var timeTaken: TimeInterval?
    
    // MARK: - Initialization
    
    /// Custom initializer to inject responses and quiz context into the view controller
    init?(coder: NSCoder, responses: [Answer], selectedQuiz: Quiz? = nil, timeTaken: TimeInterval? = nil) {
        self.responses = responses
        self.selectedQuiz = selectedQuiz
        self.timeTaken = timeTaken
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(coder:responses:selectedQuiz:timeTaken:) instead.")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        saveResultToHistory() // Stretch Goal 4: Save to history
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Result Calculation
    
    /// Calculates which animal personality type the user matches
    func calculatePersonalityResult() {
        // Count frequency of each animal type
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        
        for response in responses {
            let type = response.type
            frequencyOfAnswers[type, default: 0] += 1
        }
        
        // Find the most frequent animal type
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.value > $1.value }.first!.key
        
        // Update UI based on quiz type (animal or color)
        if selectedQuiz?.title.contains("Color") == true {
            // Color quiz result
            resultAnswerLabel.text = "You are a \(mostCommonAnswer.colorName)"
            resultDefinitionLabel.text = mostCommonAnswer.colorDefinition
        } else {
            // Animal quiz result
            resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
            resultDefinitionLabel.text = mostCommonAnswer.definition
        }
    }
    
    // MARK: - Save Result to History (Stretch Goal 4)
    
    /// Saves the quiz result to local storage for history tracking
    func saveResultToHistory() {
        // Calculate the result animal
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        for response in responses {
            frequencyOfAnswers[response.type, default: 0] += 1
        }
        
        guard let mostCommonAnswer = frequencyOfAnswers.sorted(by: { $0.value > $1.value }).first?.key else {
            return
        }
        
        // Create a QuizResult entry
        let result = QuizResult(
            id: UUID(),
            quizTitle: selectedQuiz?.title ?? "Personality Quiz",
            quizEmoji: selectedQuiz?.emoji ?? "🦁🐱🐰🐢",
            resultAnimal: mostCommonAnswer,
            date: Date(),
            timeTaken: timeTaken ?? 0
        )
        
        // Save to UserDefaults
        var history = QuizHistoryManager.shared.loadHistory()
        history.append(result)
        QuizHistoryManager.shared.saveHistory(history)
        
        print("✅ Quiz result saved to history: \(result.resultDisplayText)")
    }
}
