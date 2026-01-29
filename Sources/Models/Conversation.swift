import Foundation

struct Conversation: Identifiable, Codable {
    let id: UUID
    var title: String
    var messages: [ChatMessage]
    let createdAt: Date
    var lastUpdated: Date
    
    init(id: UUID = UUID(), title: String = "New Chat", messages: [ChatMessage] = [], createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.messages = messages
        self.createdAt = createdAt
        self.lastUpdated = createdAt
    }
    
    mutating func addMessage(_ message: ChatMessage) {
        messages.append(message)
        lastUpdated = Date()
    }
    
    var preview: String {
        messages.last?.text ?? "No messages yet"
    }
}
