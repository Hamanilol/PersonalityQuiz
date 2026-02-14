//
//  QuizSelectionViewController.swift
//  Personality Quiz
//
//  Created by May Abdulla on 09/02/2026.
//

import UIKit

/// Displays a modal for selecting which quiz to take (Stretch Goal 1)
class QuizSelectionViewController: UIViewController {
    
    // MARK: - Properties
    
    /// The quiz selected by the user
    var selectedQuiz: Quiz?
    
    // MARK: - IBOutlets (Optional - for UI updates)
    
    @IBOutlet weak var animalQuizButton: UIButton?
    @IBOutlet weak var colorQuizButton: UIButton?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonStates()
    }
    
    // MARK: - UI Updates
    
    /// Updates button appearance based on selection
    private func updateButtonStates() {
        // You can style the selected button differently here
        // For example, change background color or border
        
        animalQuizButton?.layer.borderWidth = 2
        colorQuizButton?.layer.borderWidth = 2
        
        if selectedQuiz?.title.contains("Animal") == true {
            animalQuizButton?.layer.borderColor = UIColor.systemRed.cgColor
            colorQuizButton?.layer.borderColor = UIColor.clear.cgColor
        } else if selectedQuiz?.title.contains("Color") == true {
            colorQuizButton?.layer.borderColor = UIColor.systemRed.cgColor
            animalQuizButton?.layer.borderColor = UIColor.clear.cgColor
        } else {
            animalQuizButton?.layer.borderColor = UIColor.clear.cgColor
            colorQuizButton?.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    // MARK: - Actions
    
    /// User selected the Animal quiz
    @IBAction func animalQuizButtonPressed(_ sender: UIButton) {
        selectedQuiz = QuizManager.shared.availableQuizzes.first { $0.title.contains("Animal") }
        updateButtonStates()
        print("✅ User selected Animal quiz")
        
        // Optionally dismiss immediately
        // performSegue(withIdentifier: "unwindFromQuizSelection", sender: self)
    }
    
    /// User selected the Color quiz
    @IBAction func colorQuizButtonPressed(_ sender: UIButton) {
        selectedQuiz = QuizManager.shared.availableQuizzes.first { $0.title.contains("Color") }
        updateButtonStates()
        print("✅ User selected Color quiz")
        
        // Optionally dismiss immediately
        // performSegue(withIdentifier: "unwindFromQuizSelection", sender: self)
    }
    
    /// User tapped Cancel button
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        selectedQuiz = nil  // Don't change selection
        dismiss(animated: true)
        print("❌ User cancelled quiz selection")
    }
    
    /// User tapped Back button
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
        print("⬅️ User went back from quiz selection")
    }
}
