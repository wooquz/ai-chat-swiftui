import Foundation
import SwiftUI

@MainActor
class ChatViewModel: ObservableObject {
    @Published var conversations: [Conversation] = []
    @Published var currentConversation: Conversation?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let openAIService: OpenAIService
    
    init() {
        self.openAIService = OpenAIService()
        loadConversations()
    }
    
    func createNewConversation() {
        let newConversation = Conversation()
        conversations.insert(newConversation, at: 0)
        currentConversation = newConversation
        saveConversations()
    }
    
    func sendMessage(_ text: String) async {
        guard !text.isEmpty, var conversation = currentConversation else { return }
        
        let userMessage = ChatMessage(text: text, isUser: true)
        conversation.addMessage(userMessage)
        updateConversation(conversation)
        
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await openAIService.sendMessage(text, conversationHistory: conversation.messages)
            let aiMessage = ChatMessage(text: response, isUser: false)
            conversation.addMessage(aiMessage)
            updateConversation(conversation)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    private func updateConversation(_ conversation: Conversation) {
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            conversations[index] = conversation
            currentConversation = conversation
            saveConversations()
        }
    }
    
    func deleteConversation(_ conversation: Conversation) {
        conversations.removeAll { $0.id == conversation.id }
        if currentConversation?.id == conversation.id {
            currentConversation = conversations.first
        }
        saveConversations()
    }
    
    private func saveConversations() {
        if let data = try? JSONEncoder().encode(conversations) {
            UserDefaults.standard.set(data, forKey: "conversations")
        }
    }
    
    private func loadConversations() {
        if let data = UserDefaults.standard.data(forKey: "conversations"),
           let saved = try? JSONDecoder().decode([Conversation].self, from: data) {
            conversations = saved
            currentConversation = conversations.first
        }
    }
}
