import Foundation

struct Config {
    static let openAIAPIKey: String = {
        if let key = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] {
            return key
        }
        return "YOUR_API_KEY_HERE"
    }()
    
    static let openAIEndpoint = "https://api.openai.com/v1/chat/completions"
    static let model = "gpt-3.5-turbo"
}
