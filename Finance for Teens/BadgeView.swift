import SwiftUI

struct BadgeView: View {
    let badge: Badge
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: badge.icon)
                .font(.system(size: 30))
                .foregroundColor(badge.isEarned ? .yellow : .gray)
            
            Text(badge.name)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .frame(width: 80, height: 80)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(badge.isEarned ? Color.yellow.opacity(0.5) : Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    BadgeView(badge: Badge(
        name: "Test Badge",
        icon: "star.fill",
        description: "Test Description",
        isEarned: true
    ))
} 