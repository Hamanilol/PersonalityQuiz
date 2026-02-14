//
//  IntroductionViewController.swift
//  Personality Quiz
//
//  Created by May Abdulla on 08/02/2026.
//

import UIKit

/// Displays the introduction screen for the personality quiz
class IntroductionViewController: UIViewController {
    
    // MARK: - Properties
    
    /// The quiz selected by the user (Stretch Goal 1: Multiple quiz support)
    /// Default to Animal quiz if none selected
    var selectedQuiz: Quiz? {
        didSet {
            updateUIForSelectedQuiz()
        }
    }
    
    // MARK: - IBOutlets (Optional - for updating UI dynamically)
    
    @IBOutlet weak var emojiLabel: UILabel?
    @IBOutlet weak var titleLabel: UILabel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default quiz to Animal quiz
        if selectedQuiz == nil {
            selectedQuiz = QuizManager.shared.availableQuizzes.first
        }
        
        updateUIForSelectedQuiz()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update UI in case quiz was changed
        updateUIForSelectedQuiz()
    }
    
    // MARK: - UI Updates
    
    /// Updates the home screen UI to reflect the currently selected quiz
    private func updateUIForSelectedQuiz() {
        guard let quiz = selectedQuiz else { return }
        
        // Update emoji and title labels if connected
        emojiLabel?.text = quiz.emoji
        titleLabel?.text = quiz.title
        
        print("✅ Selected quiz: \(quiz.title)")
    }
    
    // MARK: - Actions
    
    /// Prepares for the segue to the question screen (Stretch Goal 1: Pass selected quiz)
    @IBSegueAction func showQuestionViewController(_ coder: NSCoder) -> QuestionViewController? {
        // Use selected quiz or default to Animal quiz
        let quiz = selectedQuiz ?? QuizManager.shared.availableQuizzes.first!
        
        return QuestionViewController(
            coder: coder,
            questions: quiz.questions,
            selectedQuiz: quiz  // ✅ Pass the selected quiz!
        )
    }
    
    /// Unwind segue to return to the introduction screen from results
    @IBAction func unwindToIntroduction(_ unwindSegue: UIStoryboardSegue) {
        // This method enables the unwind segue from results back to intro
        print("✅ Returned to introduction screen")
    }
    
    /// Unwind segue from quiz selection modal (Stretch Goal 1)
    @IBAction func unwindFromQuizSelection(_ unwindSegue: UIStoryboardSegue) {
        // Get the selected quiz from QuizSelectionViewController
        if let quizSelectionVC = unwindSegue.source as? QuizSelectionViewController,
           let quiz = quizSelectionVC.selectedQuiz {
            self.selectedQuiz = quiz
            print("✅ User selected quiz: \(quiz.title)")
        }
    }
}
