import SwiftUI

struct Badge: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let description: String
    var isEarned: Bool
}

class UserData: ObservableObject {
    @Published var username: String = "Teen Investor"
    @Published var savingsGoal: Double = 1000.0
    @Published var currentSavings: Double = 250.0
    @Published var lessonsCompleted: Int = 0
    @Published var totalLessons: Int = 7
    @Published var quizScores: [String: Int] = [:] // [QuizType: Score]
    @Published var savingsStreak: Int = 0
    @Published var badges: [Badge] = [
        Badge(name: "Savings Starter", icon: "star.fill", description: "Started your savings journey!", isEarned: false),
        Badge(name: "Budget Master", icon: "chart.pie.fill", description: "Created your first budget", isEarned: false),
        Badge(name: "Investment Rookie", icon: "dollarsign.circle.fill", description: "Learn about investments", isEarned: false),
        Badge(name: "Quiz Champion", icon: "crown.fill", description: "Score 100% on any quiz", isEarned: false),
        Badge(name: "Goal Achiever", icon: "flag.fill", description: "Reach your first savings goal", isEarned: false)
    ]
    
    // Badge earning functions
    func checkAndAwardBadges() {
        // Check Savings Starter
        if currentSavings > 0 {
            awardBadge("Savings Starter")
        }
        
        // Check Budget Master
        if !quizScores.filter({ $0.key.contains("Budget") }).isEmpty {
            awardBadge("Budget Master")
        }
        
        // Check Investment Rookie
        if !quizScores.filter({ $0.key.contains("Investment") }).isEmpty {
            awardBadge("Investment Rookie")
        }
        
        // Check Quiz Champion
        if quizScores.values.contains(100) {
            awardBadge("Quiz Champion")
        }
        
        // Check Goal Achiever
        if currentSavings >= savingsGoal {
            awardBadge("Goal Achiever")
        }
    }
    
    private func awardBadge(_ name: String) {
        if let index = badges.firstIndex(where: { $0.name == name }) {
            badges[index].isEarned = true
        }
    }
    
    // Quiz tracking
    func updateQuizScore(type: String, score: Int) {
        quizScores[type] = score
        checkAndAwardBadges()
        
        // Specific badge checks based on quiz type
        switch type {
        case "Budget":
            if score >= 80 {
                awardBadge("Budget Master")
            }
        case "Investment":
            if score >= 80 {
                awardBadge("Investment Rookie")
            }
        default:
            break
        }
    }
    
    // Savings tracking
    func updateSavings(_ amount: Double) {
        let previousSavings = currentSavings
        currentSavings = amount
        
        if currentSavings > previousSavings {
            updateSavingsStreak()
        }
        
        checkAndAwardBadges()
    }
    
    // Lesson completion tracking
    func completeLesson() {
        lessonsCompleted += 1
        checkAndAwardBadges()
    }
    
    // Add a function to track savings streak
    func updateSavingsStreak() {
        // Increment streak if savings increased
        if currentSavings > 0 {
            savingsStreak += 1
        } else {
            // Reset streak if no savings
            savingsStreak = 0
        }
    }
} 