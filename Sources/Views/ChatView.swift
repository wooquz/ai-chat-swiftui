import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var messageText = ""
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if let conversation = viewModel.currentConversation {
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(conversation.messages) { message in
                                    MessageRow(message: message)
                                        .id(message.id)
                                }
                                
                                if viewModel.isLoading {
                                    HStack {
                                        ProgressView()
                                            .scaleEffect(0.8)
                                        Text("Thinking...")
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()
                                }
                            }
                            .padding()
                        }
                        .onChange(of: conversation.messages.count) { _ in
                            if let lastMessage = conversation.messages.last {
                                withAnimation {
                                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                } else {
                    VStack {
                        Image(systemName: "bubble.left.and.bubble.right")
                            .font(.system(size: 60))
                            .foregroundColor(.secondary)
                        Text("Start a new conversation")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                }
                
                Divider()
                
                HStack(spacing: 12) {
                    TextField("Message", text: $messageText)
                        .textFieldStyle(.roundedBorder)
                        .focused($isInputFocused)
                        .onSubmit {
                            sendMessage()
                        }
                    
                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(messageText.isEmpty ? .gray : .blue)
                    }
                    .disabled(messageText.isEmpty || viewModel.isLoading)
                }
                .padding()
            }
            .navigationTitle(viewModel.currentConversation?.title ?? "Chat")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.createNewConversation() }) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }
    }
    
    private func sendMessage() {
        let text = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        
        messageText = ""
        Task {
            await viewModel.sendMessage(text)
        }
    }
}
