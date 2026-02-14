//
//  HistoryTableViewController.swift
//  Personality Quiz
//
//  Created by May Abdulla on 09/02/2026.
//

import UIKit

/// Displays a list of previously completed quiz results (Stretch Goal 4)
class HistoryTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    /// Array of saved quiz results
    var quizHistory: [QuizResult] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up navigation
        title = "Quiz History"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(clearHistoryTapped)
        )
        
        // Load history from storage
        loadHistory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload history in case new results were added
        loadHistory()
    }
    
    // MARK: - Data Loading
    
    /// Loads quiz history from UserDefaults
    func loadHistory() {
        quizHistory = QuizHistoryManager.shared.loadHistory()
        quizHistory = quizHistory.reversed() // Show newest first
        tableView.reloadData()
        
        print("✅ Loaded \(quizHistory.count) quiz results")
    }
    
    // MARK: - Actions
    
    /// Clears all quiz history
    @objc func clearHistoryTapped() {
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
    
    // MARK: - TableView Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if quizHistory.isEmpty {
            // Show a message if no history
            let messageLabel = UILabel(frame: tableView.bounds)
            messageLabel.text = "No quiz results yet.\nTake a quiz to see your history!"
            messageLabel.textAlignment = .center
            messageLabel.numberOfLines = 0
            messageLabel.textColor = .systemGray
            tableView.backgroundView = messageLabel
            tableView.separatorStyle = .none
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
        
        return quizHistory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "HistoryCell")
        
        let result = quizHistory[indexPath.row]
        
        // Configure cell
        cell.textLabel?.text = result.resultDisplayText
        cell.detailTextLabel?.text = "\(result.quizTitle) • \(result.formattedDate) • \(result.formattedTime)"
        cell.detailTextLabel?.textColor = .systemGray
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let result = quizHistory[indexPath.row]
        
        // Show detail alert
        let alert = UIAlertController(
            title: result.resultDisplayText,
            message: """
            Quiz: \(result.quizTitle)
            Completed: \(result.formattedDate)
            Time Taken: \(result.formattedTime)
            """,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove from array
            quizHistory.remove(at: indexPath.row)
            
            // Save updated history (need to reverse back to original order)
            var savedHistory = quizHistory.reversed()
            QuizHistoryManager.shared.saveHistory(Array(savedHistory))
            
            // Delete row with animation
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Reload to show empty state if needed
            if quizHistory.isEmpty {
                tableView.reloadData()
            }
        }
    }
}
