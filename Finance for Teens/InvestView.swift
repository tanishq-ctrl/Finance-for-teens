import SwiftUI

struct InvestQuizQuestion {
    let question: String
    let options: [String]
    let correctAnswer: Int
}

struct InvestTopic: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let icon: String
    let gradient: [Color]
}

struct InvestView: View {
    @State private var showingQuiz = false
    let topics = [
        InvestTopic(
            title: "What is Investing?",
            content: "Investing is like planting a tree 🌱 It takes time to grow, but the rewards are worth it! Imagine collecting rare items that increase in value over time. Start small, dream big! 💫",
            icon: "chart.line.uptrend.xyaxis",
            gradient: [.blue, .purple]
        ),
        InvestTopic(
            title: "Why Start Early?",
            content: "The magic of compounding! 🪄 Your money earns money, which then earns more money. Like a snowball growing bigger as it rolls. Starting with just $10 a month can grow into something amazing! 💰",
            icon: "clock.arrow.circlepath",
            gradient: [.purple, .pink]
        ),
        InvestTopic(
            title: "Types of Investments",
            content: "🏢 Stocks: Own a piece of your favorite companies\n💰 Bonds: Lend money and earn interest\n🧺 Mutual Funds: A mix of investments managed by experts",
            icon: "square.grid.2x2.fill",
            gradient: [.orange, .red]
        ),
        InvestTopic(
            title: "Risk and Reward",
            content: "Think of investing like a video game 🎮 Higher levels (risks) can give bigger rewards, but you might face more challenges. Don't put all your coins in one power-up! 🎯",
            icon: "chart.bar.xaxis",
            gradient: [.green, .blue]
        ),
        InvestTopic(
            title: "Getting Started",
            content: "Ready to begin your investment journey? 🚀 Start small, learn as you go, and watch your money grow! Use investment apps to practice before using real money. 📱",
            icon: "play.fill",
            gradient: [.mint, .green]
        )
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(topics) { topic in
                        InvestCardView(topic: topic)
                    }
                    
                    // Interactive Quiz Button
                    Button(action: {
                        showingQuiz = true
                    }) {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .font(.title2)
                            Text("Take the Investment Quiz!")
                                .font(.headline)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Invest")
            .sheet(isPresented: $showingQuiz) {
                InvestQuizView()
            }
        }
    }
}

struct InvestCardView: View {
    let topic: InvestTopic
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack(spacing: 12) {
                Image(systemName: topic.icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Circle().fill(Color.white.opacity(0.2)))
                
                Text(topic.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            // Content
            Text(topic.content)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
                .lineLimit(isExpanded ? nil : 3)
                .animation(.spring(), value: isExpanded)
            
            // Expand/Collapse Button
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                Text(isExpanded ? "Show Less" : "Learn More")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: topic.gradient),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct InvestQuizView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var showingResults = false
    @EnvironmentObject var userData: UserData
    
    var questions: [InvestQuizQuestion] {
        [
            InvestQuizQuestion(
                question: "What is compound interest?",
                options: [
                    "Interest earned only on the principal amount",
                    "Interest earned on both principal and accumulated interest",
                    "A fixed interest rate that never changes",
                    "Interest paid to the bank"
                ],
                correctAnswer: 1
            ),
            InvestQuizQuestion(
                question: "Why is it beneficial to start investing early?",
                options: [
                    "Because you'll have more money to invest",
                    "Because the stock market only goes up early in life",
                    "Because you have more time for compound interest to work",
                    "Because investments are cheaper when you're young"
                ],
                correctAnswer: 2
            ),
            InvestQuizQuestion(
                question: "What is diversification?",
                options: [
                    "Putting all your money in one successful company",
                    "Spreading your investments across different types of assets",
                    "Only investing in popular stocks",
                    "Keeping all your money in a savings account"
                ],
                correctAnswer: 1
            ),
            InvestQuizQuestion(
                question: "Which is typically considered the riskiest type of investment?",
                options: [
                    "Government bonds",
                    "Savings account",
                    "Individual stocks",
                    "Certificate of Deposit (CD)"
                ],
                correctAnswer: 2
            ),
            InvestQuizQuestion(
                question: "What is a mutual fund?",
                options: [
                    "A type of savings account",
                    "A collection of different investments managed by professionals",
                    "A government bond",
                    "A type of cryptocurrency"
                ],
                correctAnswer: 1
            )
        ]
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if !showingResults {
                    // Question Card
                    VStack(alignment: .leading, spacing: 16) {
                        // Progress Indicator
                        HStack {
                            Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                                .font(.headline)
                                .foregroundColor(.blue)
                            
                            Spacer()
                            
                            Text("Score: \(score)")
                                .font(.headline)
                                .foregroundColor(.green)
                        }
                        
                        // Question
                        Text(questions[currentQuestionIndex].question)
                            .font(.title3)
                            .bold()
                            .padding(.vertical)
                        
                        // Options
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
                        
                        // Show encouraging message based on score
                        Text(getEncouragementMessage())
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                        
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
            .navigationTitle("Investment Quiz")
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
            finishQuiz()
        }
    }
    
    private func resetQuiz() {
        currentQuestionIndex = 0
        score = 0
        showingResults = false
    }
    
    private func finishQuiz() {
        let score = (score * 100) / questions.count
        userData.updateQuizScore(type: "Investment", score: score)
        showingResults = true
    }
    
    private func getEncouragementMessage() -> String {
        let percentage = Double(score) / Double(questions.count)
        switch percentage {
        case 1.0:
            return "Perfect score! You're a financial genius! 🌟"
        case 0.8..<1.0:
            return "Excellent work! You're well on your way to becoming an investing pro! 🚀"
        case 0.6..<0.8:
            return "Good job! Keep learning and you'll master investing in no time! 📈"
        default:
            return "Keep practicing! Every investment master started as a beginner! 💪"
        }
    }
}

#Preview {
    InvestView()
        .environmentObject(UserData())
} 