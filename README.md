# 🦁 Personality Quiz - iOS Mobile App

**IT8108: Mobile Programming - Re-Assessment 2025-2026**

A fully-featured iOS personality quiz application implementing multiple quiz types, dynamic question randomization, persistent history tracking, and timed gameplay.

---

## 📱 Project Overview

This project is a comprehensive implementation of the **Personality Quiz** guided project from Apple's *Develop with Swift Fundamentals* curriculum (pages 533-600), extended with all required stretch goals and additional features for the IT8108 Mobile Programming re-assessment.

### Quiz Topics
- 🦁🐱🐰🐢 **Which Animal Are You?** - Discover your spirit animal
- 🔴🟡🟢🔵 **What's Your Color?** - Find your personality color

---

## ✨ Features

### Base Implementation ✅
- ✅ **Introduction Screen** - Welcome players and explain the quiz
- ✅ **Three Question Types:**
  - **Single Answer** - Choose one option from multiple choices
  - **Multiple Answer** - Select multiple options using switches
  - **Ranged Answer** - Choose intensity using a slider
- ✅ **Result Calculation** - Determine personality based on answers
- ✅ **Results Display** - Show personalized result with description
- ✅ **Navigation Flow** - Smooth transitions between screens

### Stretch Goals (All 5 Implemented) ✅

#### 1. Multiple Quiz Selection 🎯
- Players can choose between different personality quizzes
- Dedicated quiz selection screen
- Each quiz has unique questions and results

#### 2. Randomization 🔀
- **Questions randomized** on each quiz attempt
- **Answers shuffled** within each question
- Ensures unique experience every time

#### 3. Dynamic Answer Counts 🔢
- Support for varying numbers of answers per question
- Programmatic UI creation using Stack Views
- Buttons/switches created dynamically based on question data
- Scales from 2 to 10+ answer options

#### 4. Quiz History 📊
- **Persistent storage** using `UserDefaults`
- View past quiz results with:
  - Result (e.g., "You are a 🦁!")
  - Quiz name
  - Completion date
  - Time taken to complete
- **Clear history** functionality with confirmation
- Displays up to 3 most recent results

#### 5. Question Timer ⏱️
- **30-second countdown** for each question
- Visual timer display updates every second
- Automatic progression to next question when time expires
- Total quiz time tracked and displayed in history

### Additional Features 🌟
- **Singleton pattern** for quiz and history management
- **Codable persistence** for type-safe data storage
- **Memory-safe timers** using `[weak self]`
- **Unwind segues** for proper navigation flow
- **Custom initializers** for data passing between view controllers
- **Comprehensive inline documentation**

---

## 🏗️ Architecture

### MVC Design Pattern

```
PersonalityQuiz/
│
├── Models/
│   ├── Question.swift          # Quiz questions and answer types
│   ├── QuizResult.swift        # History records and persistence
│   └── QuizManager.swift       # Quiz selection and state management
│
├── Views/
│   └── Main.storyboard         # All UI screens and layouts
│
└── Controllers/
    ├── IntroductionViewController.swift      # Home screen
    ├── QuizSelectionViewController.swift     # Quiz picker
    ├── QuestionViewController.swift          # Main quiz logic
    ├── ResultsViewController.swift           # Result display
    └── HistoryTableViewController.swift      # Quiz history
```

### Key Design Patterns
- **Singleton** - `QuizManager.shared`, `QuizHistoryManager.shared`
- **Delegation** - Timer management, table view data source
- **Custom Initializers** - Type-safe data passing through segues
- **Target-Action** - Button and control event handling

---

## 🎨 UI/UX Design

### Design Principles Applied

| Principle | Implementation |
|-----------|----------------|
| **Balance** | Centered layouts with equal margins (20pt) |
| **Contrast** | Color-coded buttons for different question types |
| **Alignment** | Stack views ensure consistent element alignment |
| **Simplicity** | One question displayed at a time, minimal clutter |
| **Proximity** | Related elements grouped in stack views |
| **Rhythm** | Consistent button styling and spacing throughout |
| **White Space** | Generous margins prevent overcrowding |

### Gestalt Principles Applied

| Principle | Implementation |
|-----------|----------------|
| **Visibility** | Progress bar shows quiz completion status |
| **Feedback** | Button highlights on tap, visual timer countdown |
| **Movement** | Smooth segue transitions between screens |
| **Connectedness** | Navigation bar connects all screens |
| **Constraints** | Buttons and controls clearly indicate interactivity |
| **Affordance** | UI elements look interactive (buttons, switches, sliders) |

### Responsive Design
- **AutoLayout constraints** ensure compatibility across device sizes
- **Stack views** adapt to different screen widths
- **Dynamic Type** support for accessibility
- **Target iOS 17.0+**

---

## 🔧 Technical Implementation

### Custom Initializers

Data is passed between view controllers using custom initializers for type safety:

```swift
// QuestionViewController receives selected quiz
init?(coder: NSCoder, quiz: Quiz)

// ResultsViewController receives quiz responses
init?(coder: NSCoder, responses: [Answer])
```

### Persistence Layer

Quiz history is stored using `UserDefaults` with `Codable` protocol:

```swift
struct QuizResult: Codable {
    let quizTitle: String
    let resultType: String
    let resultDescription: String
    let completionDate: Date
    let timeTaken: Int
}
```

### Memory Management

Timers use weak references to prevent retain cycles:

```swift
questionTimer = Timer.scheduledTimer(
    withTimeInterval: 1.0,
    repeats: true
) { [weak self] _ in
    self?.timerTick()
}
```

### Dynamic UI Creation

Answer options are created programmatically based on question data:

```swift
func createAnswerButtons(for answers: [Answer]) {
    // Remove existing buttons
    singleStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    
    // Create new buttons dynamically
    for (index, answer) in answers.enumerated() {
        let button = createStyledButton(title: answer.text, tag: index)
        singleStackView.addArrangedSubview(button)
    }
}
```

---

## 📊 Project Structure

### View Controllers (5)

| View Controller | Responsibility | Outlets | Actions |
|----------------|----------------|---------|---------|
| `IntroductionViewController` | Home screen, quiz entry point | 1 | 0 |
| `QuizSelectionViewController` | Choose quiz topic | 2 | 3 |
| `QuestionViewController` | Display questions & handle answers | 21 | Multiple |
| `ResultsViewController` | Show personality result | 2 | 0 |
| `HistoryTableViewController` | Display quiz history | 15 | 2 |

### Models (3)

| Model | Purpose |
|-------|---------|
| `Question.swift` | Defines question structure with three answer types |
| `QuizResult.swift` | Stores completed quiz data for history |
| `QuizManager.swift` | Manages available quizzes and current quiz state |

### Managers (2)

| Manager | Pattern | Purpose |
|---------|---------|---------|
| `QuizManager` | Singleton | Provides quiz selection and randomization |
| `QuizHistoryManager` | Singleton | Handles persistent history storage |

---

## 🚀 Setup Instructions

### Requirements
- **macOS** 12.0 or later
- **Xcode** 15.0 or later
- **iOS Simulator** or physical device running iOS 17.0+
- **Swift** 5.9+

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/PersonalityQuiz.git
   cd PersonalityQuiz
   ```

2. **Open in Xcode:**
   ```bash
   open PersonalityQuiz.xcodeproj
   ```

3. **Select a simulator or device:**
   - Click the scheme dropdown next to the Run button
   - Choose **iPhone 15** or your preferred simulator

4. **Build and run:**
   - Press **⌘R** or click the **Play** button
   - App should launch in simulator

## 🎮 How to Use

### Taking a Quiz

1. **Launch the app** - Introduction screen appears
2. **Tap "Select Quiz"** - Choose between animal or color quiz
3. **Select a quiz** - Tap your preferred quiz option
4. **Answer questions:**
   - **Single answer:** Tap one button
   - **Multiple answer:** Toggle switches for your choices, tap "Submit"
   - **Ranged answer:** Slide to your preference, tap "Submit"
5. **View results** - See your personality type with description
6. **Tap "Done"** - Return to home screen

### Viewing History

1. From home screen, tap **"Results"**
2. View up to 3 most recent quiz results
3. Each entry shows:
   - Your result (e.g., "You are a 🦁!")
   - Quiz name
   - Completion date
   - Time taken
4. Tap **"Clear"** to delete all history (with confirmation)
5. Tap **"Back"** to return home

### Timer Behavior

- Each question has a **30-second timer**
- Timer displays in upper-right corner
- Countdown updates every second
- Auto-advances when time expires
- Total quiz time saved to history

---

## 📸 Screenshots

### Main Screens

**Introduction Screen**
- Welcome message with emoji
- "Begin Personality Quiz" button
- Access to Results and Quiz Selection

**Quiz Selection Screen**
- Two quiz options with emoji indicators
- Clean card-based layout
- Cancel button to return

**Question Screen (Single Answer)**
- Question text at top
- Progress bar showing completion
- Timer countdown
- Four answer buttons

**Question Screen (Multiple Answer)**
- Question text
- Four switches with labels
- Submit button to proceed

**Question Screen (Ranged)**
- Question text
- Slider with min/max labels
- Submit button

**Results Screen**
- Large emoji representing result
- Result text (e.g., "You are a 🦁!")
- Personality description
- Done button

**History Screen**
- Up to 3 result cards
- Each shows result, quiz, date, time
- Clear button with confirmation
- Back button

All code includes comprehensive documentation:
- **Class headers** explain purpose and responsibilities
- **MARK comments** organize code sections
- **Function documentation** describes parameters and behavior
- **Complex logic** has explanatory comments

### Documentation Structure

```swift
/// Brief description of class
///
/// Detailed explanation of purpose, usage, and patterns
class ViewController: UIViewController {
    
    // MARK: - Properties
    // Property declarations with inline comments
    
    // MARK: - Outlets
    // IBOutlet declarations grouped by purpose
    
    // MARK: - Lifecycle
    // viewDidLoad, viewWillAppear, etc.
    
    // MARK: - Setup
    // Configuration methods
    
    // MARK: - Actions
    // @IBAction methods
    
    // MARK: - Helper Methods
    // Private utility functions
}
```

---

#
## 🎨 Figma Prototype

### Interactive Prototype Link

🔗 **[View Figma Prototype](https://www.figma.com/design/NdWjCzxK6OThvUfPN9xskt/Untitled?node-id=0-1&p=f&t=RstcwEtLLorNm5ju-0)** *(Link to be added)*

### Prototype Features

The Figma prototype includes:
- ✅ All 5 main screens (Introduction, Quiz Selection, Question, Results, History)
- ✅ Interactive transitions between screens
- ✅ Clickable buttons and controls
- ✅ Three question type variations
- ✅ Animation transitions for user flow
- ✅ High-fidelity design matching implementation

### Prototype Screens

1. **Introduction Screen**
   - Welcome message
   - Three navigation buttons
   - Clean layout with emoji

2. **Quiz Selection Screen**
   - Two quiz cards
   - Cancel button
   - Hover states

3. **Question Screen - Single Answer**
   - Question text
   - Progress bar
   - Timer
   - Four answer buttons

4. **Question Screen - Multiple Answer**
   - Question text
   - Four switches
   - Submit button

5. **Question Screen - Ranged**
   - Question text
   - Slider control
   - Min/max labels
   - Submit button

6. **Results Screen**
   - Result emoji
   - Result text
   - Description
   - Done button

7. **History Screen**
   - Three result cards
   - Clear button
   - Back button

---

## 📝 References & Resources

### External Libraries

**None** - This project uses only native iOS frameworks:
- `UIKit` - UI components and view controllers
- `Foundation` - Data structures and persistence

### Apple Frameworks Used

| Framework | Purpose |
|-----------|---------|
| `UIKit` | All UI components, view controllers, navigation |
| `Foundation` | Data types, UserDefaults, Codable, Timer |

### Learning Resources

- **Develop with Swift Fundamentals** (Apple Education) - Base project guide
- **Apple Human Interface Guidelines** - UI/UX best practices
- **Swift Documentation** - Language reference

### Code Attribution

All code is original implementation following the assessment requirements. No third-party code or libraries were used.
