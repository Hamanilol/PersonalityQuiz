//
//  QuizResult.swift
//  Personality Quiz
//
//  Created by May Abdulla on 09/02/2026.
//

import Foundation

// MARK: - QuizResult Model

/// Represents a completed quiz result for history tracking (Stretch Goal 4)
struct QuizResult: Codable, Identifiable {
    let id: UUID
    let quizTitle: String
    let quizEmoji: String
    let resultAnimal: AnimalType
    let date: Date
    let timeTaken: TimeInterval // Stretch Goal 5: Timer
    
    /// Formatted time string (e.g., "1m 45s")
    var formattedTime: String {
        let minutes = Int(timeTaken) / 60
        let seconds = Int(timeTaken) % 60
        return "\(minutes)m \(seconds)s"
    }
    
    /// Formatted date string (e.g., "Jan 15, 2026 2:30 PM")
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy h:mm a"
        return formatter.string(from: date)
    }
    
    /// Display text for result (handles both animal and color quizzes)
    var resultDisplayText: String {
        if quizTitle.contains("Color") {
            return "\(resultAnimal.colorEmoji) You are a \(resultAnimal.colorName)"
        } else {
            return "\(resultAnimal.rawValue) You are a \(resultAnimal.rawValue)!"
        }
    }
}

// MARK: - QuizHistoryManager

/// Manager class for saving and loading quiz history (Stretch Goal 4)
class QuizHistoryManager {
    static let shared = QuizHistoryManager()
    
    private let historyKey = "quizHistoryKey"
    
    private init() {}
    
    /// Load saved quiz history from UserDefaults
    func loadHistory() -> [QuizResult] {
        guard let data = UserDefaults.standard.data(forKey: historyKey),
              let history = try? JSONDecoder().decode([QuizResult].self, from: data) else {
            print("⚠️ No quiz history found or failed to decode")
            return []
        }
        print("✅ Loaded \(history.count) quiz results from history")
        return history
    }
    
    /// Save quiz history to UserDefaults
    func saveHistory(_ history: [QuizResult]) {
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: historyKey)
            print("✅ Saved \(history.count) quiz results to history")
        } else {
            print("❌ Failed to encode quiz history")
        }
    }
    
    /// Clear all quiz history
    func clearHistory() {
        UserDefaults.standard.removeObject(forKey: historyKey)
        print("🗑️ Cleared all quiz history")
    }
}
