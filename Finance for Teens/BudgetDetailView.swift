import SwiftUI

struct BudgetDetailView: View {
    let scenario: BudgetScenario
    @State private var sliderValue: Double = 0
    @State private var showingQuiz = false
    @State private var progress: Double = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header Section
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: iconForScenario(scenario.title))
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Circle().fill(Color.white.opacity(0.2)))
                        
                        Text(scenario.title)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                    Text(scenario.description)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: gradientForScenario(scenario.title)),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                
                // Key Points Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Key Learning Points")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.blue)
                    
                    ForEach(scenario.keyPoints, id: \.self) { point in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 16))
                            
                            Text(point)
                                .font(.body)
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                // Enhanced Savings Tracker Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Savings Progress")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.blue)
                    
                    VStack(spacing: 20) {
                        // Goal Information
                        VStack(spacing: 12) {
                            HStack {
                                Text("💰 Target Amount:")
                                    .font(.headline)
                                Spacer()
                                Text("$\(getTargetAmount())")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                            
                            HStack {
                                Text("⏱️ Time Frame:")
                                    .font(.headline)
                                Spacer()
                                Text(calculateTimeFrame(scenario.title))
                                    .font(.headline)
                                    .foregroundColor(.green)
                            }
                            
                            HStack {
                                Text("💵 Required Monthly Savings:")
                                    .font(.headline)
                                Spacer()
                                Text(calculateMonthlySavings(scenario.title))
                                    .font(.headline)
                                    .foregroundColor(.purple)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        
                        // Progress Tracker
                        VStack(spacing: 12) {
                            Text("Track Your Progress")
                                .font(.headline)
                                .foregroundColor(.blue)
                            
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 20)
                                
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: gradientForScenario(scenario.title)),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: max(0, min(UIScreen.main.bounds.width - 80, (UIScreen.main.bounds.width - 80) * progress)), height: 20)
                            }
                            
                            // Current Savings Input
                            VStack(spacing: 8) {
                                Slider(value: $sliderValue, in: 0...Double(getTargetAmount()), step: 1) { editing in
                                    if !editing {
                                        withAnimation {
                                            progress = sliderValue / Double(getTargetAmount())
                                        }
                                    }
                                }
                                .accentColor(gradientForScenario(scenario.title)[0])
                                
                                HStack {
                                    Text("Current Savings: $\(Int(sliderValue))")
                                        .foregroundColor(.blue)
                                    Spacer()
                                    Text("Remaining: $\(getTargetAmount() - Int(sliderValue))")
                                        .foregroundColor(progress < 1.0 ? .red : .green)
                                }
                                .font(.subheadline)
                            }
                            
                            // Time Remaining
                            if progress < 1.0 {
                                Text("Keep going! You're \(Int(progress * 100))% there!")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            } else {
                                Text("Congratulations! You've reached your goal! 🎉")
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                }
                .padding(20)
                .background(Color(.systemBackground))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                // Quiz Section
                VStack(alignment: .leading, spacing: 16) {
                    Button(action: {
                        showingQuiz = true
                    }) {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .font(.title2)
                            Text("Take the Quiz!")
                                .font(.headline)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: gradientForScenario(scenario.title)),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                    }
                }
                .padding(20)
                .background(Color(.systemBackground))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingQuiz) {
            QuizView(scenario: scenario)
        }
    }
    
    private func iconForScenario(_ title: String) -> String {
        switch title {
        case "Gaming Console Goal":
            return "gamecontroller.fill"
        case "Movie Night Plan":
            return "film.fill"
        case "School Supplies":
            return "book.fill"
        case "Birthday Gift for a Friend":
            return "gift.fill"
        case "Surprise Expense":
            return "exclamationmark.triangle.fill"
        case "Holiday Savings":
            return "snowflake"
        case "Eating Out":
            return "fork.knife"
        case "Emergency Fund":
            return "shield.lefthalf.fill"
        case "Concert Ticket Goal":
            return "music.note"
        case "Daily Snack Budget":
            return "cart.fill"
        default:
            return "questionmark.circle"
        }
    }
    
    private func gradientForScenario(_ title: String) -> [Color] {
        switch title {
        case "Gaming Console Goal":
            return [.purple, .blue]
        case "Movie Night Plan":
            return [.red, .orange]
        case "School Supplies":
            return [.blue, .cyan]
        case "Birthday Gift for a Friend":
            return [.pink, .purple]
        case "Surprise Expense":
            return [.orange, .red]
        case "Holiday Savings":
            return [.mint, .green]
        case "Eating Out":
            return [.indigo, .purple]
        case "Emergency Fund":
            return [.blue, .indigo]
        case "Concert Ticket Goal":
            return [.purple, .pink]
        case "Daily Snack Budget":
            return [.green, .mint]
        default:
            return [.blue, .purple]
        }
    }
    
    private func calculateTotalAmount(_ title: String) -> String {
        switch title {
        case "Gaming Console Goal":
            return "$300"
        case "Movie Night Plan":
            return "$20"
        case "School Supplies":
            return "$40"
        case "Birthday Gift for a Friend":
            return "$25"
        case "Surprise Expense":
            return "$60"
        case "Holiday Savings":
            return "$150"
        case "Eating Out":
            return "$15"
        case "Emergency Fund":
            return "$100"
        case "Concert Ticket Goal":
            return "$80"
        case "Daily Snack Budget":
            return "$42"
        default:
            return "$0"
        }
    }
    
    private func calculateTimeFrame(_ title: String) -> String {
        switch title {
        case "Gaming Console Goal":
            return "6 months"
        case "Movie Night Plan":
            return "1 week"
        case "School Supplies":
            return "1 month"
        case "Birthday Gift for a Friend":
            return "3 weeks"
        case "Surprise Expense":
            return "2 months"
        case "Holiday Savings":
            return "4 months"
        case "Eating Out":
            return "1 week"
        case "Emergency Fund":
            return "Ongoing"
        case "Concert Ticket Goal":
            return "2 months"
        case "Daily Snack Budget":
            return "2 weeks"
        default:
            return "N/A"
        }
    }
    
    private func calculateMonthlySavings(_ title: String) -> String {
        switch title {
        case "Gaming Console Goal":
            return "$50"
        case "Movie Night Plan":
            return "$20/week"
        case "School Supplies":
            return "$40"
        case "Birthday Gift for a Friend":
            return "$8.33/week"
        case "Surprise Expense":
            return "$30"
        case "Holiday Savings":
            return "$37.50"
        case "Eating Out":
            return "$15/week"
        case "Emergency Fund":
            return "$25"
        case "Concert Ticket Goal":
            return "$40"
        case "Daily Snack Budget":
            return "$21/week"
        default:
            return "$0"
        }
    }
    
    private func getTargetAmount() -> Int {
        switch scenario.title {
        case "Gaming Console Goal": return 300
        case "Movie Night Plan": return 20
        case "School Supplies": return 40
        case "Birthday Gift for a Friend": return 25
        case "Surprise Expense": return 60
        case "Holiday Savings": return 150
        case "Eating Out": return 15
        case "Emergency Fund": return 100
        case "Concert Ticket Goal": return 80
        case "Daily Snack Budget": return 42
        default: return 0
        }
    }
}

// Quiz View
struct QuizView: View {
    let scenario: BudgetScenario
    @Environment(\.presentationMode) var presentationMode
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var showingResults = false
    
    var questions: [QuizQuestion] {
        getQuestionsForScenario(scenario.title)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if !showingResults {
                    // Question Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        Text(questions[currentQuestionIndex].question)
                            .font(.title3)
                            .bold()
                        
                        VStack(spacing: 12) {
                            ForEach(questions[currentQuestionIndex].options.indices, id: \.self) { index in
                                Button(action: {
                                    checkAnswer(index)
                                }) {
                                    Text(questions[currentQuestionIndex].options[index])
                                        .font(.body)
                                        .foregroundColor(.primary)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                } else {
                    // Results View
                    VStack(spacing: 20) {
                        Image(systemName: score >= questions.count / 2 ? "star.fill" : "star")
                            .font(.system(size: 60))
                            .foregroundColor(.yellow)
                        
                        Text("Quiz Complete!")
                            .font(.title)
                            .bold()
                        
                        Text("You scored \(score) out of \(questions.count)")
                            .font(.headline)
                        
                        Button("Try Again") {
                            resetQuiz()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .padding()
            .navigationTitle("Budget Quiz")
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func checkAnswer(_ selectedIndex: Int) {
        if selectedIndex == questions[currentQuestionIndex].correctAnswer {
            score += 1
        }
        
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            showingResults = true
        }
    }
    
    private func resetQuiz() {
        currentQuestionIndex = 0
        score = 0
        showingResults = false
    }
}

// Quiz Question Model
struct QuizQuestion {
    let question: String
    let options: [String]
    let correctAnswer: Int
}

// Quiz Questions for each scenario
func getQuestionsForScenario(_ title: String) -> [QuizQuestion] {
    switch title {
    case "Gaming Console Goal":
        return [
            QuizQuestion(
                question: "How much should you save monthly to reach your $300 goal in 6 months?",
                options: ["$25", "$50", "$75", "$100"],
                correctAnswer: 1
            ),
            QuizQuestion(
                question: "What's a good strategy to save for the gaming console?",
                options: ["Spend all allowance immediately", "Save half of monthly allowance", "Borrow money", "Wait for prices to drop"],
                correctAnswer: 1
            ),
            QuizQuestion(
                question: "If you save $50 monthly, how long will it take to reach $300?",
                options: ["3 months", "6 months", "9 months", "12 months"],
                correctAnswer: 1
            )
        ]
    case "Movie Night Plan":
        return [
            QuizQuestion(
                question: "With a $20 weekly allowance and a $12 movie ticket, how much is left for snacks?",
                options: ["$4", "$8", "$10", "$15"],
                correctAnswer: 1
            ),
            QuizQuestion(
                question: "What's the best way to plan for movie night expenses?",
                options: ["Borrow money", "Skip the movie", "Budget ahead of time", "Spend without planning"],
                correctAnswer: 2
            ),
            QuizQuestion(
                question: "How can you reduce movie night costs?",
                options: ["Go on discount days", "Buy extra snacks", "Choose 3D movies", "Buy multiple tickets"],
                correctAnswer: 0
            )
        ]
    case "School Supplies":
        return [
            QuizQuestion(
                question: "How many weeks of $10 chore money do you need to save $40?",
                options: ["2 weeks", "4 weeks", "6 weeks", "8 weeks"],
                correctAnswer: 1
            ),
            QuizQuestion(
                question: "What's the best approach to buying school supplies?",
                options: ["Buy everything at once", "Make a list and budget", "Buy the cheapest items", "Wait until school starts"],
                correctAnswer: 1
            ),
            QuizQuestion(
                question: "How can you make your school supply budget go further?",
                options: ["Buy only branded items", "Look for sales and deals", "Buy everything new", "Ignore prices"],
                correctAnswer: 1
            )
        ]
    // Add similar question sets for other scenarios
    default:
        return []
    }
} 