//
//  Question-Models.swift
//  Personality Quiz
//
//  Created by May Abdulla on 08/02/2026.
//

import Foundation

// MARK: - Question

/// Represents a single question in the personality quiz
struct Question {
    let text: String
    let type: ResponseType
    let answers: [Answer]
}

// MARK: - ResponseType

/// Defines how the user can respond to a question
enum ResponseType {
    case single
    case multiple
    case ranged
}

// MARK: - Answer

/// Represents a possible answer to a question
struct Answer {
    let text: String
    let type: AnimalType
}

// MARK: - AnimalType

/// The possible personality quiz results
enum AnimalType: Character, CaseIterable, Codable {
    case lion = "🦁"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .lion:
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .cat:
            return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
        case .rabbit:
            return "You love everything that's soft. You are healthy and full of energy."
        case .turtle:
            return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
        }
    }
    
    // MARK: - Color Quiz Support
    
    /// Color representation for color quiz
    var colorEmoji: String {
        switch self {
        case .lion:
            return "🔴" // Red - Passionate, energetic, action-oriented
        case .cat:
            return "🟣" // Purple - Creative, mysterious, independent
        case .rabbit:
            return "🟡" // Yellow - Cheerful, optimistic, warm
        case .turtle:
            return "🔵" // Blue - Calm, thoughtful, peaceful
        }
    }
    
    var colorDefinition: String {
        switch self {
        case .lion:
            return "Red represents your passionate and energetic nature. You're action-oriented, bold, and love to take charge!"
        case .cat:
            return "Purple represents your creative and mysterious personality. You're unique, imaginative, and value independence."
        case .rabbit:
            return "Yellow represents your cheerful and optimistic spirit. You're warm, friendly, and bring joy to others!"
        case .turtle:
            return "Blue represents your calm and thoughtful demeanor. You're peaceful, reliable, and value harmony."
        }
    }
    
    var colorName: String {
        switch self {
        case .lion: return "Red"
        case .cat: return "Purple"
        case .rabbit: return "Yellow"
        case .turtle: return "Blue"
        }
    }
}

// Note: Quiz struct is defined in QuizManager.swift to avoid ambiguity

// MARK: - Sample Questions

extension Question {
    /// Sample questions for the "Which Animal Are You?" quiz
    static let sampleQuestions: [Question] = [
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
    
    /// Color quiz questions (Stretch Goal 1: Multiple quiz support)
    static let colorQuizQuestions: [Question] = [
        Question(
            text: "What environment makes you happiest?",
            type: .single,
            answers: [
                Answer(text: "Vibrant city life", type: .lion),      // Red
                Answer(text: "Artistic studio", type: .cat),         // Purple
                Answer(text: "Sunny beach", type: .rabbit),          // Yellow
                Answer(text: "Peaceful mountains", type: .turtle)    // Blue
            ]
        ),
        Question(
            text: "How do you prefer to spend your free time?",
            type: .multiple,
            answers: [
                Answer(text: "Socializing with friends", type: .lion),
                Answer(text: "Creating art", type: .cat),
                Answer(text: "Outdoor activities", type: .rabbit),
                Answer(text: "Reading and learning", type: .turtle)
            ]
        ),
        Question(
            text: "How adventurous are you?",
            type: .ranged,
            answers: [
                Answer(text: "Very cautious", type: .turtle),
                Answer(text: "Moderately careful", type: .rabbit),
                Answer(text: "Quite bold", type: .cat),
                Answer(text: "Extremely daring", type: .lion)
            ]
        )
    ]
    
    // MARK: - Test Questions (Stretch Goal 3: Dynamic answer count)
    
    /// Test question with only 2 answers
    static let twoAnswerQuestion = Question(
        text: "Are you a morning person or a night owl?",
        type: .single,
        answers: [
            Answer(text: "Morning person 🌅", type: .rabbit),
            Answer(text: "Night owl 🦉", type: .cat)
        ]
    )
    
    /// Test question with 3 answers
    static let threeAnswerQuestion = Question(
        text: "What's your preferred pace?",
        type: .single,
        answers: [
            Answer(text: "Fast and energetic", type: .lion),
            Answer(text: "Moderate and steady", type: .rabbit),
            Answer(text: "Slow and careful", type: .turtle)
        ]
    )
}
