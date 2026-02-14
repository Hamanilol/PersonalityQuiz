//
//  QuizSelectionViewController.swift
//  PersonalityQuiz
//
//  Created on February 13, 2026.
//

import UIKit

class QuizSelectionViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// Button to select the animal personality quiz
    @IBOutlet weak var animalQuizButton: UIButton!
    
    /// Button to select the color personality quiz (stretch goal)
    @IBOutlet weak var colorQuizButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureButtons()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        title = "Select a Quiz"
        
        // Configure navigation bar
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureButtons() {
        // Style the buttons
        styleButton(animalQuizButton, title: "🦁 Animal Personality", color: .systemBlue)
        styleButton(colorQuizButton, title: "🎨 Color Personality", color: .systemGreen)
    }
    
    private func styleButton(_ button: UIButton, title: String, color: UIColor) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.layer.cornerRadius = 10
        
        // Use configuration instead of deprecated contentEdgeInsets
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseBackgroundColor = color
        config.baseForegroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        config.cornerStyle = .medium
        button.configuration = config
    }
    
    // MARK: - Properties
    
    /// The currently selected quiz
    var selectedQuiz: Quiz?
    
    // MARK: - Actions
    
    /// Called when user taps the animal quiz button
    @IBAction func animalQuizButtonPressed(_ sender: UIButton) {
        selectedQuiz = QuizManager.shared.animalQuiz
        print("✅ Selected Animal Quiz")
        performSegue(withIdentifier: "ShowQuestions", sender: nil)
    }
    
    /// Called when user taps the color quiz button (stretch goal)
    @IBAction func colorQuizButtonPressed(_ sender: UIButton) {
        selectedQuiz = QuizManager.shared.colorQuiz
        print("✅ Selected Color Quiz")
        performSegue(withIdentifier: "ShowQuestions", sender: nil)
    }
    
    /// Called when user taps the cancel button
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    /// Alternative back button action (if using custom back button)
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowQuestions" {
            // Quiz is already set in QuizManager.shared.currentQuiz
            // QuestionViewController will read it from there via @IBSegueAction
            print("✅ Navigating to QuestionViewController")
        }
    }
}

// MARK: - Storyboard Connections
// See MASTER_STORYBOARD_CONNECTIONS.md for complete setup instructions

