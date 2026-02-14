//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created on February 13, 2026.
//

import UIKit

class QuestionViewController: UIViewController {
    
    // MARK: - Outlets - Question Display
    
    /// Displays the current question text
    @IBOutlet weak var questionLabel: UILabel!
    
    /// Shows quiz progress (0.0 to 1.0)
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    /// Displays remaining time for timed questions (stretch goal)
    @IBOutlet weak var timerLabel: UILabel!
    
    // MARK: - Outlets - Single Answer Stack View
    
    /// Container for single-answer question buttons
    @IBOutlet weak var singleStackView: UIStackView!
    
    /// Button for first answer option
    @IBOutlet weak var singleButton1: UIButton!
    
    /// Button for second answer option
    @IBOutlet weak var singleButton2: UIButton!
    
    /// Button for third answer option
    @IBOutlet weak var singleButton3: UIButton!
    
    /// Button for fourth answer option
    @IBOutlet weak var singleButton4: UIButton!
    
    // MARK: - Outlets - Multiple Answer Stack View
    
    /// Container for multiple-answer question (labels + switches)
    @IBOutlet weak var multipleStackView: UIStackView!
    
    /// Label for first answer option
    @IBOutlet weak var multiLabel1: UILabel!
    
    /// Label for second answer option
    @IBOutlet weak var multiLabel2: UILabel!
    
    /// Label for third answer option
    @IBOutlet weak var multiLabel3: UILabel!
    
    /// Label for fourth answer option
    @IBOutlet weak var multiLabel4: UILabel!
    
    /// Switch to enable/disable first answer
    @IBOutlet weak var multiSwitch1: UISwitch!
    
    /// Switch to enable/disable second answer
    @IBOutlet weak var multiSwitch2: UISwitch!
    
    /// Switch to enable/disable third answer
    @IBOutlet weak var multiSwitch3: UISwitch!
    
    /// Switch to enable/disable fourth answer
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    // MARK: - Outlets - Ranged Answer Stack View
    
    /// Container for ranged-answer question (slider)
    @IBOutlet weak var rangedStackView: UIStackView!
    
    /// Label for minimum range value
    @IBOutlet weak var rangedLabel1: UILabel!
    
    /// Label for maximum range value
    @IBOutlet weak var rangedLabel2: UILabel!
    
    /// Slider for selecting answer within a range
    @IBOutlet weak var rangedSlider: UISlider!
    
    // MARK: - Properties
    
    /// The quiz being taken
    private var quiz: Quiz
    
    /// Current question index (0-based)
    private var questionIndex = 0
    
    /// Collection of user's selected answers
    private var answersChosen: [Answer] = []
    
    /// Timer for timed questions (stretch goal)
    private var questionTimer: Timer?
    
    /// Remaining seconds for current question (stretch goal)
    private var timeRemaining: Int = 30
    
    // MARK: - Computed Properties
    
    /// Get all questions from the current quiz
    private var questions: [Question] {
        return quiz.questions
    }
    
    /// Get the current question
    private var currentQuestion: Question {
        return questions[questionIndex]
    }
    
    /// Check if this is the last question
    private var isLastQuestion: Bool {
        return questionIndex >= questions.count - 1
    }
    
    // MARK: - Initialization
    
    /// Custom initializer required for passing quiz data
    init?(coder: NSCoder, quiz: Quiz) {
        self.quiz = quiz
        super.init(coder: coder)
    }
    
    /// Required initializer (will crash if called - use init?(coder:quiz:))
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init?(coder:quiz:) instead.")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        // Configure navigation bar
        navigationItem.hidesBackButton = true
        
        // Configure progress view
        questionProgressView.progress = 0.0
        questionProgressView.progressTintColor = .systemBlue
        questionProgressView.trackTintColor = .systemGray4
        
        // Configure timer label (hidden by default)
        timerLabel?.isHidden = true
        
        // Configure buttons
        configureSingleAnswerButtons()
    }
    
    private func configureSingleAnswerButtons() {
        let buttons = [singleButton1, singleButton2, singleButton3, singleButton4]
        
        buttons.forEach { button in
            button?.layer.cornerRadius = 8
            button?.backgroundColor = .systemBlue
            button?.setTitleColor(.white, for: .normal)
            button?.titleLabel?.numberOfLines = 0
            button?.titleLabel?.textAlignment = .center
            
            // Use configuration API instead of deprecated contentEdgeInsets
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = .systemBlue
            config.baseForegroundColor = .white
            config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
            button?.configuration = config
        }
    }
    
    // MARK: - UI Updates
    
    /// Updates all UI elements for the current question
    func updateUI() {
        // Hide all stack views initially
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentAnswers = currentQuestion.answers
        
        // Update navigation title
        navigationItem.title = "Question #\(questionIndex + 1)"
        
        // Update question label
        questionLabel.text = currentQuestion.text
        
        // Update progress view
        let totalProgress = Float(questionIndex) / Float(questions.count)
        questionProgressView.setProgress(totalProgress, animated: true)
        
        // Show the appropriate stack view based on question type
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
        
        // Start timer if needed (stretch goal)
        // startTimer()
    }
    
    /// Configures UI for single-answer questions
    private func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    /// Configures UI for multiple-answer questions
    private func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        
        // Reset switches to off
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        
        // Update labels
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    /// Configures UI for ranged-answer questions
    private func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        
        // Reset slider to middle
        rangedSlider.setValue(0.5, animated: false)
        
        // Update labels with first and last answer
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    // MARK: - Actions - Single Answer
    
    /// Called when user taps any single-answer button
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = currentQuestion.answers
        
        // Determine which button was pressed
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    // MARK: - Actions - Multiple Answer
    
    /// Called when user taps Submit Answer in multiple-answer mode
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = currentQuestion.answers
        
        // Add all selected answers
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    // MARK: - Actions - Ranged Answer
    
    /// Called when user taps Submit Answer in ranged mode
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = currentQuestion.answers
        
        // Calculate index based on slider value
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    // MARK: - Navigation
    
    /// Moves to next question or shows results
    private func nextQuestion() {
        stopTimer()
        
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    /// Prepares data for ResultsViewController
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
    }
    
    // MARK: - Timer (Stretch Goal)
    
    /// Starts a countdown timer for the current question
    private func startTimer() {
        stopTimer() // Clear any existing timer
        
        timeRemaining = 30
        timerLabel?.isHidden = false
        updateTimerLabel()
        
        questionTimer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { [weak self] _ in
            self?.timerTick()
        }
    }
    
    /// Updates the timer label text
    private func updateTimerLabel() {
        timerLabel?.text = "⏱ Time: \(timeRemaining)s"
        
        // Change color when running out of time
        if timeRemaining <= 10 {
            timerLabel?.textColor = .systemRed
        } else {
            timerLabel?.textColor = .label
        }
    }
    
    /// Called every second while timer is running
    private func timerTick() {
        timeRemaining -= 1
        updateTimerLabel()
        
        if timeRemaining <= 0 {
            stopTimer()
            handleTimerExpired()
        }
    }
    
    /// Stops and invalidates the timer
    private func stopTimer() {
        questionTimer?.invalidate()
        questionTimer = nil
    }
    
    /// Called when timer reaches 0
    private func handleTimerExpired() {
        // Auto-select a random answer or skip question
        let alert = UIAlertController(
            title: "Time's Up!",
            message: "Moving to next question...",
            preferredStyle: .alert
        )
        
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                alert.dismiss(animated: true)
                self?.nextQuestion()
            }
        }
    }
}

// MARK: - Storyboard Connection Instructions

/*
 📋 STORYBOARD SETUP CHECKLIST (QuestionViewController):
 
 ═══════════════════════════════════════════════════════════
 1️⃣ VIEW CONTROLLER SETUP:
 ═══════════════════════════════════════════════════════════
 ✅ Select View Controller in storyboard
 ✅ Identity Inspector: Custom Class = "QuestionViewController"
 ✅ Module = "PersonalityQuiz"
 ✅ Embed in Navigation Controller
 
 ═══════════════════════════════════════════════════════════
 2️⃣ CONNECT ALL 13 OUTLETS:
 ═══════════════════════════════════════════════════════════
 
 Open Assistant Editor (⌥⌘↩), then Control-drag each element to code:
 
 QUESTION DISPLAY (3 outlets):
 ┌────────────────────────────────────────┐
 │ ✅ questionLabel          (UILabel)     │
 │ ✅ questionProgressView   (UIProgressView) │
 │ ✅ timerLabel             (UILabel)     │
 └────────────────────────────────────────┘
 
 SINGLE ANSWER STACK (5 outlets):
 ┌────────────────────────────────────────┐
 │ ✅ singleStackView        (UIStackView) │
 │ ✅ singleButton1          (UIButton)    │
 │ ✅ singleButton2          (UIButton)    │
 │ ✅ singleButton3          (UIButton)    │
 │ ✅ singleButton4          (UIButton)    │
 └────────────────────────────────────────┘
 
 MULTIPLE ANSWER STACK (9 outlets):
 ┌────────────────────────────────────────┐
 │ ✅ multipleStackView      (UIStackView) │
 │ ✅ multiLabel1            (UILabel)     │
 │ ✅ multiLabel2            (UILabel)     │
 │ ✅ multiLabel3            (UILabel)     │
 │ ✅ multiLabel4            (UILabel)     │
 │ ✅ multiSwitch1           (UISwitch)    │
 │ ✅ multiSwitch2           (UISwitch)    │
 │ ✅ multiSwitch3           (UISwitch)    │
 │ ✅ multiSwitch4           (UISwitch)    │
 └────────────────────────────────────────┘
 
 RANGED ANSWER STACK (4 outlets):
 ┌────────────────────────────────────────┐
 │ ✅ rangedStackView        (UIStackView) │
 │ ✅ rangedLabel1           (UILabel)     │
 │ ✅ rangedLabel2           (UILabel)     │
 │ ✅ rangedSlider           (UISlider)    │
 └────────────────────────────────────────┘
 
 ═══════════════════════════════════════════════════════════
 3️⃣ CONNECT ACTIONS:
 ═══════════════════════════════════════════════════════════
 
 SINGLE ANSWER (1 action, 4 buttons):
 ┌────────────────────────────────────────┐
 │ 1. Control-drag singleButton1 → code   │
 │    - Connection: Action                │
 │    - Name: singleAnswerButtonPressed   │
 │    - Type: UIButton                    │
 │    - Event: Touch Up Inside            │
 │                                        │
 │ 2. Right-click singleButton2           │
 │    - Find "Touch Up Inside"            │
 │    - Drag to singleAnswerButtonPressed │
 │                                        │
 │ 3. Repeat for singleButton3            │
 │ 4. Repeat for singleButton4            │
 └────────────────────────────────────────┘
 
 MULTIPLE ANSWER (1 action):
 ┌────────────────────────────────────────┐
 │ Control-drag Submit Button → code      │
 │ - Connection: Action                   │
 │ - Name: multipleAnswerButtonPressed    │
 │ - Type: None                           │
 │ - Event: Touch Up Inside               │
 └────────────────────────────────────────┘
 
 RANGED ANSWER (1 action):
 ┌────────────────────────────────────────┐
 │ Control-drag Submit Button → code      │
 │ - Connection: Action                   │
 │ - Name: rangedAnswerButtonPressed      │
 │ - Type: None                           │
 │ - Event: Touch Up Inside               │
 └────────────────────────────────────────┘
 
 ═══════════════════════════════════════════════════════════
 4️⃣ CREATE SEGUE TO RESULTS:
 ═══════════════════════════════════════════════════════════
 
 1. Control-drag from Question VC (yellow icon) → Results VC
 2. Choose: "Show (e.g. Push)"
 3. Select the segue → Identifier: "Results"
 
 4. Connect @IBSegueAction:
    ┌────────────────────────────────────────┐
    │ Control-drag FROM SEGUE → code         │
    │ - Connection: Segue Action             │
    │ - Name: showResults                    │
    │ - Type: ResultsViewController?         │
    │ - Arguments: Coder                     │
    └────────────────────────────────────────┘
 
 ═══════════════════════════════════════════════════════════
 5️⃣ VERIFICATION:
 ═══════════════════════════════════════════════════════════
 
 Select View Controller → Connections Inspector (⌥⌘6)
 
 ALL outlets should show FILLED circles: ●
 EMPTY circles mean NOT connected: ○
 
 Check:
 ✅ 13 outlets connected
 ✅ 3 actions connected (singleAnswer, multipleAnswer, rangedAnswer)
 ✅ 1 segue action (showResults)
 ✅ 1 segue identifier ("Results")
 
 ═══════════════════════════════════════════════════════════
 6️⃣ BUILD & TEST:
 ═══════════════════════════════════════════════════════════
 
 ⌘B (Build)
 
 If you get errors:
 ❌ "Unexpectedly found nil" → Check outlet connections
 ❌ "Cannot cast" → Check custom class is set
 ❌ "No segue with identifier" → Check segue identifier
 
 ⌘R (Run)
 
 Test:
 ✅ Answer single-answer question → advances
 ✅ Toggle switches, submit → advances
 ✅ Move slider, submit → advances
 ✅ After all questions → shows results
 
 ═══════════════════════════════════════════════════════════
*/
