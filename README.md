# AI Chat SwiftUI

## Описание

Современный AI чат-ассистент для iOS с интеграцией OpenAI API. Приложение поддерживает потоковую передачу ответов в реальном времени, сохранение истории сообщений и имеет красивый SwiftUI интерфейс.

## Возможности

- 🤖 Интеграция с OpenAI GPT API
- ⚡ Потоковая передача ответов (streaming)
- 💬 История сообщений
- 🎨 Современный SwiftUI дизайн
- 📱 Адаптивный интерфейс
- 💾 Сохранение чатов локально
- 🔄 Контекст разговора
- ⚙️ Настройка параметров модели

## Требования

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+
- OpenAI API ключ

## Установка

1. Клонируйте репозиторий:

```bash
git clone https://github.com/wooquz/ai-chat-swiftui.git
cd ai-chat-swiftui
```

2. Откройте проект:

```bash
open AIChat.xcodeproj
```

3. Добавьте ваш OpenAI API ключ в файл `Sources/Config.swift`:

```swift
struct Config {
    static let openAIKey = "YOUR_API_KEY_HERE"
}
```

## Использование

```swift
import SwiftUI

struct ContentView: View {
    @StateObject private var chatViewModel = ChatViewModel()
    
    var body: some View {
        ChatView(viewModel: chatViewModel)
    }
}
```

## Архитектура

```
AIChat/
├── Models/
│   ├── ChatMessage.swift
│   └── Conversation.swift
├── Views/
│   ├── ChatView.swift
│   └── MessageRow.swift
├── ViewModels/
│   └── ChatViewModel.swift
├── Services/
│   └── OpenAIService.swift
└── Config.swift
```

## Функции

### Потоковая передача

Приложение использует SSE (Server-Sent Events) для получения ответов в реальном времени:

```swift
func streamMessage(messages: [ChatMessage]) -> AsyncThrowingStream<String, Error> {
    // Streaming implementation
}
```

## Лицензия

MIT License

---

# AI Chat SwiftUI

## Description

Modern AI chat assistant for iOS with OpenAI API integration. The app supports real-time streaming responses, message history, and beautiful SwiftUI interface.

## Features

- 🤖 OpenAI GPT API integration
- ⚡ Real-time streaming responses
- 💬 Message history
- 🎨 Modern SwiftUI design
- 📱 Adaptive interface
- 💾 Local chat storage
- 🔄 Conversation context
- ⚙️ Model parameter configuration

## Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+
- OpenAI API key

## Installation

1. Clone the repository:

```bash
git clone https://github.com/wooquz/ai-chat-swiftui.git
cd ai-chat-swiftui
```

2. Open the project:

```bash
open AIChat.xcodeproj
```

3. Add your OpenAI API key in `Sources/Config.swift`:

```swift
struct Config {
    static let openAIKey = "YOUR_API_KEY_HERE"
}
```

## Usage

```swift
import SwiftUI

struct ContentView: View {
    @StateObject private var chatViewModel = ChatViewModel()
    
    var body: some View {
        ChatView(viewModel: chatViewModel)
    }
}
```

## Architecture

```
AIChat/
├── Models/
│   ├── ChatMessage.swift
│   └── Conversation.swift
├── Views/
│   ├── ChatView.swift
│   └── MessageRow.swift
├── ViewModels/
│   └── ChatViewModel.swift
├── Services/
│   └── OpenAIService.swift
└── Config.swift
```

## Features

### Streaming

The app uses SSE (Server-Sent Events) for real-time responses:

```swift
func streamMessage(messages: [ChatMessage]) -> AsyncThrowingStream<String, Error> {
    // Streaming implementation
}
```

## License

MIT License
