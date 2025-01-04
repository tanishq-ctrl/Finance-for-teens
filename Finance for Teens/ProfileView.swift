import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userData: UserData
    @State private var showEditProfile = false
    @State private var selectedBadge = 0
    @State private var newSavings: String = ""
    
    var averageQuizScore: String {
        if userData.quizScores.isEmpty {
            return "N/A"
        }
        let average = Double(userData.quizScores.values.reduce(0, +)) / Double(userData.quizScores.count)
        return String(format: "%.0f%%", average)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Header with Gradient Background
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.blue, .purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 100, height: 100)
                            
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                        }
                        
                        Text(userData.username)
                            .font(.title2)
                            .bold()
                        
                        Button(action: {
                            showEditProfile = true
                        }) {
                            HStack {
                                Image(systemName: "pencil")
                                Text("Edit Profile")
                            }
                            .foregroundColor(.blue)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(20)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    
                    // Combined Savings Section with Gradient
                    VStack(alignment: .leading, spacing: 16) {
                        Text("💰 Savings Progress")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        VStack(spacing: 12) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Current Savings")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text("$\(Int(userData.currentSavings))")
                                        .font(.title)
                                        .bold()
                                        .foregroundColor(.blue)
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("Goal")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text("$\(Int(userData.savingsGoal))")
                                        .font(.title)
                                        .bold()
                                        .foregroundColor(.green)
                                }
                            }
                            
                            ProgressBar(progress: userData.currentSavings / userData.savingsGoal)
                                .frame(height: 12)
                            
                            // Update Savings Input
                            VStack(spacing: 8) {
                                Text("Update Savings")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                
                                HStack {
                                    TextField("Enter amount", text: $newSavings)
                                        .keyboardType(.decimalPad)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                        )
                                    
                                    Button(action: {
                                        if let amount = Double(newSavings) {
                                            userData.updateSavings(amount)
                                            newSavings = ""
                                        }
                                    }) {
                                        Text("Update")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 10)
                                            .background(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [.blue, .purple]),
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                            )
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    
                    // Achievements Section with Animation
                    VStack(alignment: .leading, spacing: 12) {
                        Text("🏆 Achievements")
                            .font(.headline)
                            .foregroundColor(.orange)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(userData.badges.indices, id: \.self) { index in
                                    BadgeView(badge: userData.badges[index])
                                        .scaleEffect(selectedBadge == index ? 1.1 : 1.0)
                                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedBadge)
                                        .onTapGesture {
                                            withAnimation {
                                                selectedBadge = index
                                            }
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    
                    // Stats Section with Icons
                    VStack(alignment: .leading, spacing: 16) {
                        Text("📊 Your Stats")
                            .font(.headline)
                            .foregroundColor(.purple)
                        
                        StatsRow(icon: "book.fill", title: "Lessons Completed", value: "\(userData.lessonsCompleted)/\(userData.totalLessons)", color: .blue)
                        StatsRow(icon: "star.fill", title: "Quiz Score", value: averageQuizScore, color: .orange)
                        StatsRow(icon: "flame.fill", title: "Savings Streak", value: "\(userData.savingsStreak) days", color: .red)
                        StatsRow(icon: "trophy.fill", title: "Badges Earned", value: "\(userData.badges.filter { $0.isEarned }.count)/\(userData.badges.count)", color: .yellow)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Profile")
            .sheet(isPresented: $showEditProfile) {
                EditProfileView(username: $userData.username, savingsGoal: $userData.savingsGoal)
            }
        }
    }
}

struct ProgressBar: View {
    let progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue, .purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: min(CGFloat(progress) * geometry.size.width, geometry.size.width))
            }
        }
        .frame(height: 20)
        .cornerRadius(10)
    }
}

struct StatsRow: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 20))
            
            Text(title)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .bold()
                .foregroundColor(color)
        }
    }
}

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var username: String
    @Binding var savingsGoal: Double
    @State private var tempUsername: String = ""
    @State private var tempSavingsGoal: Double = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Information")) {
                    TextField("Username", text: $tempUsername)
                    
                    HStack {
                        Text("Savings Goal: $")
                        TextField("Amount", value: $tempSavingsGoal, format: .number)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    username = tempUsername
                    savingsGoal = tempSavingsGoal
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .onAppear {
                tempUsername = username
                tempSavingsGoal = savingsGoal
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserData())
} 
