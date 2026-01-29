import SwiftUI

struct MessageRow: View {
    let message: ChatMessage
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if !message.isUser {
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 24))
                    .foregroundColor(.purple)
                    .frame(width: 32, height: 32)
            }
            
            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(message.isUser ? Color.blue : Color.gray.opacity(0.2))
                    )
                    .foregroundColor(message.isUser ? .white : .primary)
                
                Text(message.displayTime)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            if message.isUser {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.blue)
                    .frame(width: 32, height: 32)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.isUser ? .trailing : .leading)
    }
}
