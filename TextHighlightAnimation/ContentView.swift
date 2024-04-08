import SwiftUI

struct ContentView: View {
    @State private var isHighlightEnabled = false
    
    private let sentence = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit
"""
    
    var body: some View {
        VStack {
            Spacer()
            
            highligh(words: ["dolor", "adipiscing"], in: sentence)
                .highlight(isHighlightEnabled)
            
            Spacer()
            buttons
        }
        .padding()
    }
    
    private func highligh(words: [String], in text: String) -> Text {
        guard !text.isEmpty && !words.isEmpty else { return Text(text) }
        
        var result = Text("")
        let parts = text.components(separatedBy: " ")
        
        for (index, part) in parts.enumerated() {
            if words.contains(part.trimmingCharacters(in: .punctuationCharacters)) {
                result = result + Text(part)
                    .bold()
                    .foregroundStyle(isHighlightEnabled ? .red : .black)
                    
            } else {
                result = result + Text(part)
            }
            
            if index < parts.count - 1 {
                result = result + Text(" ")
            }
        }
        
        return result
    }
    
    private var buttons: some View {
        HStack {
            Button("Highlight") {
                withAnimation {
                    isHighlightEnabled = true
                }
            }
            
            Button("Reset") {
                withAnimation {
                    isHighlightEnabled = false
                }
            }
        }
    }
}

extension View {
    func highlight(_ isEnabled: Bool) -> some View {
        modifier(HighlightedModifier(isEnabled: isEnabled))
    }
}

struct HighlightedModifier: ViewModifier {
    let isEnabled: Bool
    
    func body(content: Content) -> some View {
        content
            .padding(2)
            .background(
                GeometryReader { geometry in
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.yellow)
                            .frame(
                                width: isEnabled ? geometry.size.width : .zero,
                                height: geometry.size.height
                            )
                        Spacer()
                    }
                }
            )
    }
}

#Preview {
    ContentView()
}
