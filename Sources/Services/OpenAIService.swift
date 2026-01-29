import Foundation

struct Message: Codable, Identifiable {
    let id: UUID
    let role: String
    let content: String
    let timestamp: Date
    
    init(role: String, content: String) {
        self.id = UUID()
        self.role = role
        self.content = content
        self.timestamp = Date()
    }
}

struct ChatCompletionRequest: Codable {
    let model: String
    let messages: [MessagePayload]
    let stream: Bool
    let temperature: Double
    
    struct MessagePayload: Codable {
        let role: String
        let content: String
    }
}

struct ChatCompletionResponse: Codable {
    let id: String
    let choices: [Choice]
    
    struct Choice: Codable {
        let message: MessageContent
        let finishReason: String?
        
        struct MessageContent: Codable {
            let role: String
            let content: String
        }
        
        enum CodingKeys: String, CodingKey {
            case message
            case finishReason = "finish_reason"
        }
    }
}

class OpenAIService {
    private let apiKey: String
    private let baseURL = "https://api.openai.com/v1/chat/completions"
    
    init(apiKey: String = Config.openAIKey) {
        self.apiKey = apiKey
    }
    
    func sendMessage(messages: [Message], model: String = "gpt-3.5-turbo") async throws -> String {
        let url = URL(string: baseURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let messagePayloads = messages.map { 
            ChatCompletionRequest.MessagePayload(role: $0.role, content: $0.content)
        }
        
        let requestBody = ChatCompletionRequest(
            model: model,
            messages: messagePayloads,
            stream: false,
            temperature: 0.7
        )
        
        request.httpBody = try JSONEncoder().encode(requestBody)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(ChatCompletionResponse.self, from: data)
        
        return response.choices.first?.message.content ?? "No response"
    }
    
    func streamMessage(messages: [Message]) -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {
                    let response = try await sendMessage(messages: messages)
                    for char in response {
                        try? await Task.sleep(nanoseconds: 10_000_000)
                        continuation.yield(String(char))
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}

