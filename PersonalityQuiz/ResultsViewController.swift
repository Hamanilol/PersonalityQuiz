//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created on February 13, 2026.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// Displays the personality result (e.g., "You are a 🦁!")
    @IBOutlet weak var resultAnswerLabel: UILabel!
    
    /// Displays the detailed description of the personality type
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    // MARK: - Properties
    
    /// User's selected answers from the quiz
    private var responses: [Answer]
    
    // MARK: - Initialization
    
    /// Custom initializer required for passing response data
    init?(coder: NSCoder, responses: [Answer]) {
        self.responses = responses
        super.init(coder: coder)
    }
    
    /// Required initializer (will crash if called)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init?(coder:responses:) instead.")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        calculatePersonalityResult()
        saveQuizResult()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        title = "Results"
        
        // Hide the back button (quiz is complete, no going back)
        navigationItem.hidesBackButton = true
        
        // Configure labels
        resultAnswerLabel.numberOfLines = 0
        resultAnswerLabel.textAlignment = .center
        
        resultDefinitionLabel.numberOfLines = 0
        resultDefinitionLabel.textAlignment = .center
    }
    
    // MARK: - Result Calculation
    
    /// Calculates the most common personality type from responses
    private func calculatePersonalityResult() {
        // Count frequency of each answer type
        let frequencyOfAnswers = responses.reduce(into: [:]) { counts, answer in
            counts[answer.type, default: 0] += 1
        }
        
        // Sort by frequency (highest first)
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.value > $1.value }.first!.key
        
        // Update UI with result
        displayResult(for: mostCommonAnswer)
    }
    
    /// Updates the labels with the personality result
    private func displayResult(for animalType: AnimalType) {
        resultAnswerLabel.text = "You are a \(animalType.rawValue)!"
        resultDefinitionLabel.text = animalType.definition
    }
    
    // MARK: - History Management (Stretch Goal)
    
    /// Saves the quiz result to persistent storage
    private func saveQuizResult() {
        guard let quiz = QuizManager.shared.currentQuiz else { return }
        
        // Calculate result
        let frequencyOfAnswers = responses.reduce(into: [:]) { counts, answer in
            counts[answer.type, default: 0] += 1
        }
        
        guard let mostCommonAnswer = frequencyOfAnswers.sorted(by: { $0.value > $1.value }).first?.key else {
            return
        }
        
        // Create quiz result with all required parameters
        let result = QuizResult(
            id: UUID(),
            quizTitle: quiz.title,
            quizEmoji: quiz.emoji,
            resultAnimal: mostCommonAnswer,
            date: Date(),
            timeTaken: 0.0 // TODO: Implement timer tracking for stretch goal
        )
        
        // Save to history
        QuizHistoryManager.shared.addResult(result)
        
        print("✅ Quiz result saved: \(mostCommonAnswer.rawValue)")
    }
}

// MARK: - Storyboard Connection Instructions

/*
 📋 STORYBOARD SETUP CHECKLIST (ResultsViewController):
 
 ═══════════════════════════════════════════════════════════
 1️⃣ VIEW CONTROLLER SETUP:
 ═══════════════════════════════════════════════════════════
 ✅ Select View Controller in storyboard
 ✅ Identity Inspector: Custom Class = "ResultsViewController"
 ✅ Module = "PersonalityQuiz"
 ✅ Should be embedded in same Navigation Controller as Questions
 
 ═══════════════════════════════════════════════════════════
 2️⃣ NAVIGATION ITEM:
 ═══════════════════════════════════════════════════════════
 ✅ Drag "Navigation Item" from Object Library
 ✅ Title: "Results"
 ✅ Add Bar Button Item to RIGHT side
 ✅ System Item: "Done"
 
 ═══════════════════════════════════════════════════════════
 3️⃣ UI LAYOUT:
 ═══════════════════════════════════════════════════════════
 
 CREATE VERTICAL STACK VIEW:
 
 1. Add UILabel #1 (Result Answer):
    ┌────────────────────────────────────────┐
    │ Text: "You are a 🦁!"                  │
    │ Font: System 50.0                      │
    │ Alignment: Center                      │
    │ Lines: 0                               │
    │ Color: System Label Color              │
    └────────────────────────────────────────┘
 
 2. Add UILabel #2 (Result Definition):
    ┌────────────────────────────────────────┐
    │ Text: "You are incredibly outgoing..." │
    │ Font: System 17.0                      │
    │ Alignment: Center                      │
    │ Lines: 0                               │
    │ Line Break: Word Wrap                  │
    │ Color: System Label Color              │
    └────────────────────────────────────────┘
 
 3. SELECT BOTH LABELS:
    ┌────────────────────────────────────────┐
    │ Click "Embed In Stack View" button     │
    │                                        │
    │ Stack View Settings:                   │
    │ - Axis: Vertical                       │
    │ - Alignment: Fill                      │
    │ - Distribution: Fill                   │
    │ - Spacing: 20                          │
    └────────────────────────────────────────┘
 
 4. STACK VIEW CONSTRAINTS:
    ┌────────────────────────────────────────┐
    │ - Leading: 20 (to Safe Area)           │
    │ - Trailing: 20 (to Safe Area)          │
    │ - Center Vertically in Container       │
    └────────────────────────────────────────┘
 
 ═══════════════════════════════════════════════════════════
 4️⃣ CONNECT OUTLETS:
 ═══════════════════════════════════════════════════════════
 
 Open Assistant Editor (⌥⌘↩):
 
 1. Control-drag Result Answer Label → code
    ┌────────────────────────────────────────┐
    │ Connection: Outlet                     │
    │ Name: resultAnswerLabel                │
    │ Type: UILabel                          │
    │ Storage: Weak                          │
    │ Click "Connect"                        │
    └────────────────────────────────────────┘
 
 2. Control-drag Result Definition Label → code
    ┌────────────────────────────────────────┐
    │ Connection: Outlet                     │
    │ Name: resultDefinitionLabel            │
    │ Type: UILabel                          │
    │ Storage: Weak                          │
    │ Click "Connect"                        │
    └────────────────────────────────────────┘
 
 ═══════════════════════════════════════════════════════════
 5️⃣ CONNECT DONE BUTTON (UNWIND SEGUE):
 ═══════════════════════════════════════════════════════════
 
 The Done button should return to IntroductionViewController.
 
 1. Control-drag from "Done" button → "Exit" icon (top of scene)
    
 2. In popup, select:
    ┌────────────────────────────────────────┐
    │ unwindToIntroduction:                  │
    └────────────────────────────────────────┘
 
 This will dismiss both ResultsViewController AND QuestionViewController,
 returning user to the start screen.
 
 ═══════════════════════════════════════════════════════════
 6️⃣ VERIFICATION:
 ═══════════════════════════════════════════════════════════
 
 Select View Controller → Connections Inspector (⌥⌘6)
 
 Check:
 ✅ resultAnswerLabel → connected (●)
 ✅ resultDefinitionLabel → connected (●)
 ✅ Done button → unwind segue connected
 
 ═══════════════════════════════════════════════════════════
 7️⃣ BUILD & TEST:
 ═══════════════════════════════════════════════════════════
 
 ⌘B (Build)
 
 If you get errors:
 ❌ "Unexpectedly found nil while unwrapping" → Outlet not connected
 ❌ "init(coder:) has not been implemented" → Using wrong initializer
 ❌ "Cannot find 'unwindToIntroduction'" → Check IntroductionViewController has this method
 
 ⌘R (Run)
 
 Test:
 ✅ Complete quiz
 ✅ Results screen shows personality type
 ✅ Results screen shows description
 ✅ Tap "Done" → returns to Introduction
 ✅ Back button should be HIDDEN
 ✅ Quiz result saved to history
 
 ═══════════════════════════════════════════════════════════
 8️⃣ EXPECTED UI:
 ═══════════════════════════════════════════════════════════
 
 ┌─────────────────────────────────────┐
 │ < Results             Done          │ ← Navigation Bar
 ├─────────────────────────────────────┤
 │                                     │
 │                                     │
 │        You are a 🦁!                │ ← Large emoji + text
 │                                     │
 │     You are incredibly outgoing.    │
 │   You surround yourself with the    │ ← Wrapped description
 │   people you love and enjoy         │
 │   activities with your friends.     │
 │                                     │
 │                                     │
 └─────────────────────────────────────┘
 
 ═══════════════════════════════════════════════════════════
*/
