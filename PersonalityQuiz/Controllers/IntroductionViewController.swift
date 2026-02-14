//
//  IntroductionViewController.swift
//  PersonalityQuiz
//
//  Created on February 13, 2026.
//

import UIKit

class IntroductionViewController: UIViewController {
    
    // MARK: - Outlets (Optional)
    
    /// Optional reference to the main title label
    @IBOutlet weak var titleLabel: UILabel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reset quiz state when returning to introduction
        QuizManager.shared.resetCurrentQuiz()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        // Configure navigation bar
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Update title if outlet is connected
        titleLabel?.text = "Which Animal Are You?"
    }
    
    // MARK: - Segue Actions
    
    /// Called when transitioning to QuestionViewController
    /// This method is connected via @IBSegueAction in storyboard
    @IBSegueAction func showQuestionViewController(_ coder: NSCoder) -> QuestionViewController? {
        guard let quiz = QuizManager.shared.currentQuiz else {
            print("⚠️ Error: No quiz selected")
            return nil
        }
        
        return QuestionViewController(coder: coder, quiz: quiz)
    }
    
    // MARK: - Unwind Segues
    
    /// Unwind segue destination from ResultsViewController
    /// Connect the Done button to this action via Exit in storyboard
    @IBAction func unwindToIntroduction(_ unwindSegue: UIStoryboardSegue) {
        // Quiz completed - could show alert or update UI
        print("✅ Returned to introduction")
        
        // Reset quiz state
        QuizManager.shared.resetCurrentQuiz()
    }
    
    /// Unwind segue from Quiz Selection when cancelled
    @IBAction func unwindFromQuizSelection(_ unwindSegue: UIStoryboardSegue) {
        print("🔙 Quiz selection cancelled")
    }
}

// MARK: - Storyboard Connection Instructions

/*
 📋 STORYBOARD SETUP CHECKLIST:
 
 1. VIEW CONTROLLER SETUP:
    ✅ Select View Controller in storyboard
    ✅ Identity Inspector: Custom Class = "IntroductionViewController"
    ✅ Module = "PersonalityQuiz"
    ✅ Check "Is Initial View Controller"
 
 2. UI ELEMENTS:
    ✅ Add UILabel (Title) - Text: "Which Animal Are You?"
    ✅ Add UIButton (Begin) - Title: "Begin Personality Quiz"
    ✅ Add 4 corner emoji labels: 🦁 🐱 🐰 🐢
 
 3. STACK VIEW:
    ✅ Select Title Label + Begin Button
    ✅ Click "Embed In Stack View"
    ✅ Stack Settings: Axis=Vertical, Spacing=20
    ✅ Constraints: Leading/Trailing=20, Center Vertically
 
 4. SEGUE TO QUIZ SELECTION:
    ✅ Control-drag from Begin Button → Navigation Controller
    ✅ Choose "Present Modally"
    ✅ Select segue → Identifier: "ShowQuizSelection"
 
 5. @IBSegueAction CONNECTION:
    ✅ Find segue from Quiz Selection → Question VC
    ✅ Control-drag from segue → this code file
    ✅ Connection: "Segue Action"
    ✅ Name: "showQuestionViewController"
    ✅ Arguments: "Coder"
    ✅ Type: "QuestionViewController?"
 
 6. UNWIND SEGUES:
    ✅ In ResultsViewController:
       - Control-drag Done Button → Exit icon
       - Select "unwindToIntroduction:"
    
    ✅ In QuizSelectionViewController:
       - Control-drag Cancel Button → Exit icon
       - Select "unwindFromQuizSelection:"
 
 7. OUTLETS (OPTIONAL):
    ✅ Control-drag Title Label → titleLabel outlet (if you want)
 
 ⚠️ IMPORTANT: The @IBSegueAction showQuestionViewController
    MUST be connected via Control-drag from the SEGUE (not a button)
    to this code. This is how custom initializers work with segues.
*/
