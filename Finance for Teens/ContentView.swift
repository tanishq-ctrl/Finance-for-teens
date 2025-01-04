//
//  ContentView.swift
//  Finance for Teens
//
//  Created by Tanishq Prabhu on 03/01/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userData = UserData()
    
    var body: some View {
        TabView {
            LessonsView()
                .tabItem {
                    Label("Lessons", systemImage: "book.fill")
                }
            
            BudgetView()
                .tabItem {
                    Label("Budget", systemImage: "chart.bar.fill")
                }
            
            InvestView()
                .tabItem {
                    Label("Invest", systemImage: "dollarsign.circle.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .environmentObject(userData)
        .background(Color.blue.opacity(0.1))
    }
}

struct LessonTopic: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let memeImage: String
    let keyPrinciples: [String]
    let dos: [String]
    let donts: [String]
    let facts: [String]
}

struct LessonDetailView: View {
    let topic: LessonTopic

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Hero Image Section with adjusted sizing
                ZStack(alignment: .bottomLeading) {
                    Image(topic.memeImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 200)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [.clear, .black.opacity(0.5)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: iconForTopic(topic.title))
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Circle().fill(Color.white.opacity(0.2)))
                            
                            Text(topic.title)
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                        }
                        
                        Text(topic.description)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                            .lineLimit(2)
                    }
                    .padding()
                }
                
                // Content Sections
                Group {
                    SectionCard(title: "Key Principles", color: .blue, items: topic.keyPrinciples, icon: "key.fill")
                    SectionCard(title: "Dos", color: .green, items: topic.dos, icon: "checkmark.circle.fill")
                    SectionCard(title: "Don'ts", color: .red, items: topic.donts, icon: "xmark.circle.fill")
                    SectionCard(title: "Interesting Facts", color: .orange, items: topic.facts, icon: "lightbulb.fill")
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func iconForTopic(_ title: String) -> String {
        switch title {
        case "Welcome to the World of Finance!":
            return "star.fill"
        case "Budgeting: Your Money's Best Friend":
            return "chart.pie.fill"
        case "Saving: The Art of Not Going Broke":
            return "banknote.fill"
        case "Investing: Making Your Money Work for You":
            return "arrow.up.right.circle.fill"
        case "Credit: Your Financial Superpower":
            return "creditcard.fill"
        case "Emergency Funds: Your Financial Safety Net":
            return "shield.fill"
        case "Smart Spending: Get More Bang for Your Buck":
            return "cart.fill"
        default:
            return "dollarsign.circle.fill"
        }
    }
}

struct SectionCard: View {
    let title: String
    let color: Color
    let items: [String]
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(color)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(items, id: \.self) { item in
                    HStack(alignment: .top, spacing: 12) {
                        Circle()
                            .fill(color)
                            .frame(width: 8, height: 8)
                            .padding(.top, 8)
                        
                        Text(item)
                            .bold()
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: color.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

struct LessonsView: View {
    let topics = [
        LessonTopic(
            title: "Welcome to the World of Finance!",
            description: "Hey there! Ready to dive into the world of finance? 🤑 Let's make money talk fun and learn smart money moves!",
            memeImage: "mocking_spongebob",
            keyPrinciples: [
                "Start Your Journey: Begin with understanding basic financial concepts and terms.",
                "Build Strong Foundations: Learn to manage, save, and grow your money wisely."
            ],
            dos: [
                "Stay Curious: Ask questions and explore financial topics that interest you.",
                "Take Small Steps: Start with basic concepts before moving to advanced topics."
            ],
            donts: [
                "Avoid Information Overload: Take your time to understand each concept clearly.",
                "Don't Feel Intimidated: Everyone starts as a beginner in finance."
            ],
            facts: [
                "78% of teens want to learn more about managing money.",
                "Early financial education can lead to better money habits in adulthood."
            ]
        ),
        LessonTopic(
            title: "Budgeting: Your Money's Best Friend",
            description: "Think of budgeting as your money's GPS. It tells you where to go and how to get there without getting lost. 🚗💨",
            memeImage: "drake_hotline_bling",
            keyPrinciples: ["Track Your Spending: Know where every dollar goes.", "Set Goals: Define what you want to achieve financially."],
            dos: ["Prioritize Needs Over Wants: Essentials come first.", "Use the 50/30/20 Rule: A balanced approach to budgeting."],
            donts: ["Ignore Small Purchases: They add up over time.", "Forget to Adjust: Update your budget as life changes."],
            facts: ["People who budget are 50% more likely to save money.", "The average person spends 20% more than they realize."]
        ),
        LessonTopic(
            title: "Saving: The Art of Not Going Broke",
            description: "Saving is like collecting Pokémon cards. The more you have, the better! 💰✨",
            memeImage: "expanding_brain",
            keyPrinciples: ["Pay Yourself First: Treat savings like a bill.", "Emergency Fund: Prepare for unexpected expenses."],
            dos: ["Automate Savings: Make saving effortless.", "Start Small: Every little bit counts."],
            donts: ["Dip Into Savings: Only for true emergencies.", "Wait to Start: The sooner, the better."],
            facts: ["A $500 emergency fund can cover most unexpected expenses.", "Automating savings can increase your savings rate by 30%."]
        ),
        LessonTopic(
            title: "Investing: Making Your Money Work for You",
            description: "Investing is like planting a tree. It takes time, but the fruits are worth it. 🌳💸",
            memeImage: "success_kid",
            keyPrinciples: ["Start Early: Time is your ally in investing.", "Diversify: Spread your investments to reduce risk."],
            dos: ["Research: Know what you're investing in.", "Think Long-Term: Patience pays off."],
            donts: ["Panic Sell: Stay calm during market dips.", "Follow the Crowd: Make informed decisions."],
            facts: ["The stock market has historically returned about 7% annually.", "Diversification can reduce investment risk by 30%."]
        ),
        LessonTopic(
            title: "Credit: Your Financial Superpower",
            description: "Credit is like a superpower. Use it wisely, and you can achieve great things. Abuse it, and it might just backfire. 🦸‍♂️💳",
            memeImage: "spiderman_pointing",
            keyPrinciples: ["Build Credit Early: Start with a secured card.", "Pay On Time: Avoid late fees and interest."],
            dos: ["Keep Balances Low: Use less than 30% of your limit.", "Check Your Credit Report: Know your score and history."],
            donts: ["Max Out Cards: It hurts your score.", "Apply for Too Many Cards: Each application affects your score."],
            facts: ["A good credit score can save you thousands in interest.", "35% of your credit score is based on payment history."]
        ),
        LessonTopic(
            title: "Emergency Funds: Your Financial Safety Net",
            description: "Think of an emergency fund as your financial cushion. It's there to catch you when life throws a curveball. 🛡️💵",
            memeImage: "this_is_fine",
            keyPrinciples: ["Save for Unexpected Events: Life is unpredictable.", "Keep it Accessible: Ensure you can access it when needed."],
            dos: ["Set a Goal: Aim for 3-6 months of expenses.", "Contribute Regularly: Make it a habit."],
            donts: ["Use for Non-Emergencies: Keep it for true needs.", "Neglect to Replenish: Top it up after use."],
            facts: ["Only 39% of Americans could cover a $1,000 emergency.", "Having an emergency fund can reduce financial stress by 50%."]
        ),
        LessonTopic(
            title: "Smart Spending: Get More Bang for Your Buck",
            description: "Smart spending is like finding the best deals on Black Friday, but every day. 🛍️💡",
            memeImage: "roll_safe",
            keyPrinciples: ["Plan Purchases: Avoid impulse buys.", "Look for Deals: Save money by shopping smart."],
            dos: ["Compare Prices: Ensure you're getting the best deal.", "Use Coupons: Take advantage of discounts."],
            donts: ["Impulse Buy: Think before you spend.", "Ignore Quality: Sometimes cheaper isn't better."],
            facts: ["Using coupons can save you up to 20% on purchases.", "Impulse buying can increase spending by 30%."]
        )
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(topics) { topic in
                        NavigationLink(destination: LessonDetailView(topic: topic)) {
                            LessonCard(topic: topic)
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Financial Lessons")
        }
    }
}

struct LessonCard: View {
    let topic: LessonTopic
    @State private var isHovered = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title and Icon Section
            HStack(spacing: 12) {
                Image(systemName: iconForTopic(topic.title))
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Circle().fill(Color.white.opacity(0.2)))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(topic.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    Text(topic.description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            
            // Image
            Image(topic.memeImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: gradientColorsForTopic(topic.title)),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
        .scaleEffect(isHovered ? 1.02 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
        .onHover { hovering in
            isHovered = hovering
        }
    }
    
    // Function to return appropriate icon for each topic
    private func iconForTopic(_ title: String) -> String {
        switch title {
        case "Welcome to the World of Finance!":
            return "star.fill"
        case "Budgeting: Your Money's Best Friend":
            return "chart.pie.fill"
        case "Saving: The Art of Not Going Broke":
            return "banknote.fill"
        case "Investing: Making Your Money Work for You":
            return "arrow.up.right.circle.fill"
        case "Credit: Your Financial Superpower":
            return "creditcard.fill"
        case "Emergency Funds: Your Financial Safety Net":
            return "shield.fill"
        case "Smart Spending: Get More Bang for Your Buck":
            return "cart.fill"
        default:
            return "dollarsign.circle.fill"
        }
    }
    
    // Function to return gradient colors for each topic
    private func gradientColorsForTopic(_ title: String) -> [Color] {
        switch title {
        case "Welcome to the World of Finance!":
            return [.blue, .purple]
        case "Budgeting: Your Money's Best Friend":
            return [.green, .blue]
        case "Saving: The Art of Not Going Broke":
            return [.purple, .pink]
        case "Investing: Making Your Money Work for You":
            return [.orange, .red]
        case "Credit: Your Financial Superpower":
            return [.blue, .indigo]
        case "Emergency Funds: Your Financial Safety Net":
            return [.red, .orange]
        case "Smart Spending: Get More Bang for Your Buck":
            return [.green, .mint]
        default:
            return [.blue, .purple]
        }
    }
}

struct BudgetScenario: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let keyPoints: [String]
    let activityDescription: String
}

struct BudgetView: View {
    let scenarios = [
        BudgetScenario(
            title: "Gaming Console Goal",
            description: "You want to buy a gaming console that costs $300. You receive $50 monthly as an allowance. How can you budget your expenses to save for the console in six months?",
            keyPoints: [
                "How to set a savings goal.",
                "Prioritizing wants vs. needs.",
                "Tracking progress toward financial goals."
            ],
            activityDescription: "Input a monthly savings plan and see if you can reach the goal in six months."
        ),
        BudgetScenario(
            title: "Movie Night Plan",
            description: "You’re planning a movie night with friends. Your total weekly allowance is $20, and the movie ticket costs $12. How will you adjust your spending for snacks and transport?",
            keyPoints: [
                "Balancing fun expenses with other needs.",
                "Making trade-offs to stay within budget."
            ],
            activityDescription: "Adjust your weekly spending plan to make room for the movie night."
        ),
        BudgetScenario(
            title: "School Supplies",
            description: "You need to buy school supplies costing $40. You earn $10 weekly from chores. How can you save enough in a month while still keeping some for fun?",
            keyPoints: [
                "Planning short-term savings.",
                "Allocating funds for essentials."
            ],
            activityDescription: "Use sliders to adjust weekly spending and reach the $40 goal."
        ),
        BudgetScenario(
            title: "Birthday Gift for a Friend",
            description: "Your friend’s birthday is in three weeks, and you want to buy a $25 gift. With a $10 weekly allowance, how will you plan to save for it?",
            keyPoints: [
                "Managing small savings over time.",
                "Sticking to a short-term goal."
            ],
            activityDescription: "Plan a weekly savings amount and simulate progress."
        ),
        BudgetScenario(
            title: "Surprise Expense",
            description: "Your headphones break unexpectedly, and you need $60 to replace them. How can you adjust your budget for the next two months to cover this cost?",
            keyPoints: [
                "Handling unexpected expenses.",
                "Reallocating budget categories."
            ],
            activityDescription: "Reallocate funds from 'wants' to 'needs' in a budget simulator."
        ),
        BudgetScenario(
            title: "Holiday Savings",
            description: "You want to save $150 for holiday shopping by December. Starting in September, how much should you save monthly if you get $40 per month in allowance?",
            keyPoints: [
                "Breaking long-term goals into manageable steps.",
                "Consistent saving habits."
            ],
            activityDescription: "Calculate the monthly savings needed and track progress."
        ),
        BudgetScenario(
            title: "Eating Out",
            description: "You plan to eat out with friends, and the average meal costs $15. Your weekly budget is $25. How will you manage the rest of the week with your remaining money?",
            keyPoints: [
                "Balancing discretionary spending.",
                "Planning around high-cost activities."
            ],
            activityDescription: "Allocate your budget for meals and other weekly expenses."
        ),
        BudgetScenario(
            title: "Emergency Fund",
            description: "You decide to start an emergency fund. With a monthly allowance of $100, how much can you save each month while still enjoying your usual activities?",
            keyPoints: [
                "Importance of emergency savings.",
                "Allocating a fixed percentage for emergencies."
            ],
            activityDescription: "Set an emergency fund amount and adjust spending to accommodate it."
        ),
        BudgetScenario(
            title: "Concert Ticket Goal",
            description: "A concert ticket costs $80, and the event is two months away. If you earn $50 monthly, how much do you need to set aside to make this goal achievable?",
            keyPoints: [
                "Breaking down savings for events.",
                "Prioritizing short-term goals."
            ],
            activityDescription: "Use a countdown tracker and simulate progress."
        ),
        BudgetScenario(
            title: "Daily Snack Budget",
            description: "You spend $3 daily on snacks but want to reduce this to save for a new book. If you cut your snack spending by half, how much will you save in two weeks?",
            keyPoints: [
                "Small adjustments add up over time.",
                "Importance of tracking daily spending."
            ],
            activityDescription: "Calculate potential savings by reducing snack costs."
        )
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(scenarios) { scenario in
                        NavigationLink(destination: BudgetDetailView(scenario: scenario)) {
                            BudgetScenarioCard(scenario: scenario)
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Budget Scenarios")
        }
    }
}

// New component for budget scenario cards
struct BudgetScenarioCard: View {
    let scenario: BudgetScenario
    @State private var isHovered = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack(spacing: 12) {
                Image(systemName: iconForScenario(scenario.title))
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Circle().fill(Color.white.opacity(0.2)))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(scenario.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(scenario.description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(2)
                }
            }
            
            // Key Points Preview
            VStack(alignment: .leading, spacing: 8) {
                Text("Key Points:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                ForEach(scenario.keyPoints.prefix(2), id: \.self) { point in
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.7))
                        
                        Text(point)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.9))
                            .lineLimit(1)
                    }
                }
            }
            .padding(.leading, 4)
        }
        .padding(16)
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
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
        .scaleEffect(isHovered ? 1.02 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
        .onHover { hovering in
            isHovered = hovering
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
}



#Preview {
    ContentView()
        .environmentObject(UserData())
}
