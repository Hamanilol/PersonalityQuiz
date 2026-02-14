//
//  HistoryTableViewController.swift
//  Personality Quiz
//
//  Created by May Abdulla on 09/02/2026.
//

import UIKit

/// Displays a list of previously completed quiz results (Stretch Goal 4)
class HistoryTableViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Array of saved quiz results
    var quizHistory: [QuizResult] = []
    
    // MARK: - Outlets
    
    // History Item 1
    @IBOutlet weak var item1View: UIView!
    @IBOutlet weak var item1ResultLabel: UILabel!
    @IBOutlet weak var item1QuizLabel: UILabel!
    @IBOutlet weak var item1DateLabel: UILabel!
    @IBOutlet weak var item1TimeLabel: UILabel!
    
    // History Item 2
    @IBOutlet weak var item2View: UIView!
    @IBOutlet weak var item2ResultLabel: UILabel!
    @IBOutlet weak var item2QuizLabel: UILabel!
    @IBOutlet weak var item2DateLabel: UILabel!
    @IBOutlet weak var item2TimeLabel: UILabel!
    
    // History Item 3
    @IBOutlet weak var item3View: UIView!
    @IBOutlet weak var item3ResultLabel: UILabel!
    @IBOutlet weak var item3QuizLabel: UILabel!
    @IBOutlet weak var item3DateLabel: UILabel!
    @IBOutlet weak var item3TimeLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Quiz History"
        
        // Load history from storage
        loadHistory()
        
        // Set up clear button
        setupClearButton()
        
        // Set up back button
        setupBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload history in case new results were added
        loadHistory()
    }
    
    // MARK: - Setup
    
    func setupClearButton() {
        // Clear button should call clearHistoryTapped when tapped
        // Connect this in storyboard as Touch Up Inside action
    }
    
    func setupBackButton() {
        // Back button should dismiss or pop view controller
        // Connect this in storyboard as Touch Up Inside action
    }
    
    // MARK: - Data Loading
    
    /// Loads quiz history from UserDefaults and updates UI
    func loadHistory() {
        quizHistory = QuizHistoryManager.shared.loadHistory()
        quizHistory = quizHistory.reversed() // Show newest first
        
        print("✅ Loaded \(quizHistory.count) quiz results")
        
        // Update UI
        updateHistoryUI()
    }
    
    /// Updates the three history item views with data
    func updateHistoryUI() {
        // Show up to 3 most recent results
        
        // Item 1
        if quizHistory.count > 0 {
            let result = quizHistory[0]
            item1View.isHidden = false
            item1ResultLabel.text = result.resultDisplayText
            item1QuizLabel.text = result.quizTitle
            item1DateLabel.text = result.formattedDate
            item1TimeLabel.text = result.formattedTime
        } else {
            item1View.isHidden = true
        }
        
        // Item 2
        if quizHistory.count > 1 {
            let result = quizHistory[1]
            item2View.isHidden = false
            item2ResultLabel.text = result.resultDisplayText
            item2QuizLabel.text = result.quizTitle
            item2DateLabel.text = result.formattedDate
            item2TimeLabel.text = result.formattedTime
        } else {
            item2View.isHidden = true
        }
        
        // Item 3
        if quizHistory.count > 2 {
            let result = quizHistory[2]
            item3View.isHidden = false
            item3ResultLabel.text = result.resultDisplayText
            item3QuizLabel.text = result.quizTitle
            item3DateLabel.text = result.formattedDate
            item3TimeLabel.text = result.formattedTime
        } else {
            item3View.isHidden = true
        }
        
        // If no history, could show empty state message
        if quizHistory.isEmpty {
            print("No quiz history to display")
            // Could show a label here saying "No quiz results yet"
        }
    }
    
    // MARK: - Actions
    
    /// Clears all quiz history
    @IBAction func clearHistoryTapped(_ sender: UIButton) {
        let alert = UIAlertController(
            title: "Clear History",
            message: "Are you sure you want to delete all quiz history? This cannot be undone.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive) { _ in
            QuizHistoryManager.shared.clearHistory()
            self.loadHistory()
            print("🗑️ Quiz history cleared")
        })
        
        present(alert, animated: true)
    }
    
    /// Goes back to previous screen
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

