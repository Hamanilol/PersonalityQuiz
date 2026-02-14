//
//  QuizManager.swift
//  Personality Quiz
//
//  Created by May Abdulla on 08/02/2026.
//

import Foundation

/// Manages quiz data and history
class QuizManager {
    static let shared = QuizManager()
    
    private let historyKey = "quizHistory"
    
    private init() {}
    
    /// All available quizzes
    var availableQuizzes: [Quiz] {
        return [animalQuiz, colorQuiz]
    }
    
    // MARK: - Animal Quiz
    var animalQuiz: Quiz {
        Quiz(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
            title: "Which Animal Are You?",
            emoji: "🐾",
            questions: [
                Question(
                    text: "Which food do you like the most?",
                    type: .single,
                    answers: [
                        Answer(text: "Steak", type: .lion),
                        Answer(text: "Fish", type: .cat),
                        Answer(text: "Carrots", type: .rabbit),
                        Answer(text: "Corn", type: .turtle)
                    ]
                ),
                Question(
                    text: "Which activities do you enjoy?",
                    type: .multiple,
                    answers: [
                        Answer(text: "Swimming", type: .turtle),
                        Answer(text: "Sleeping", type: .cat),
                        Answer(text: "Cuddling", type: .rabbit),
                        Answer(text: "Eating", type: .lion)
                    ]
                ),
                Question(
                    text: "How much do you enjoy car rides?",
                    type: .ranged,
                    answers: [
                        Answer(text: "I dislike them", type: .cat),
                        Answer(text: "I get a little nervous", type: .rabbit),
                        Answer(text: "I barely notice them", type: .turtle),
                        Answer(text: "I like them", type: .lion)
                    ]
                )
            ]
        )
    }
    
    // MARK: - Color Quiz
    var colorQuiz: Quiz {
        Quiz(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
            title: "What Color Are You?",
            emoji: "🎨",
            questions: [
                Question(
                    text: "How do you handle stress?",
                    type: .single,
                    answers: [
                        Answer(text: "Stay calm and collected", type: .turtle), // Blue
                        Answer(text: "Take action immediately", type: .lion), // Red
                        Answer(text: "Seek support from others", type: .rabbit), // Yellow
                        Answer(text: "Retreat and reflect", type: .cat) // Purple
                    ]
                ),
                Question(
                    text: "What environments do you prefer?",
                    type: .multiple,
                    answers: [
                        Answer(text: "Peaceful and quiet", type: .turtle), // Blue
                        Answer(text: "Energetic and lively", type: .lion), // Red
                        Answer(text: "Warm and welcoming", type: .rabbit), // Yellow
                        Answer(text: "Creative and inspiring", type: .cat) // Purple
                    ]
                ),
                Question(
                    text: "How emotional are you?",
                    type: .ranged,
                    answers: [
                        Answer(text: "Very logical", type: .turtle), // Blue
                        Answer(text: "Balanced", type: .cat), // Purple
                        Answer(text: "Quite emotional", type: .rabbit), // Yellow
                        Answer(text: "Very passionate", type: .lion) // Red
                    ]
                )
            ]
        )
    }
    
    // MARK: - Quiz History
    
    /// Save a completed quiz result to history
    func saveQuizResult(_ result: QuizResult) {
        var history = QuizHistoryManager.shared.loadHistory()
        history.append(result)
        QuizHistoryManager.shared.saveHistory(history)
    }
    
    /// Load all completed quiz results from history
    func loadQuizHistory() -> [QuizResult] {
        return QuizHistoryManager.shared.loadHistory()
    }
    
    /// Clear all quiz history
    func clearHistory() {
        QuizHistoryManager.shared.clearHistory()
    }
}

/// Represents a quiz with multiple questions
struct Quiz {
    let id: UUID
    let title: String
    let emoji: String
    let questions: [Question]
}

// Note: QuizResult is now defined in QuizResult.swift to avoid ambiguity
