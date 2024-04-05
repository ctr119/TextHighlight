import SwiftUI

struct ContentView: View {
    @State private var width: CGFloat = 0
    private let targetWidth: CGFloat = 50
    
    private let sentence = """
Lorem ipsum dolor sit amet
"""
    private let targetText = "ipsum dolor"
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 5) {
                ForEach(textChunks(), id: \.self) {
                    if $0 == targetText {
                        Text($0)
                            .highlight(width)
                    } else {
                        Text($0)
                    }
                }
            }
            
            Spacer()
            buttons
        }
    }
    
    private func textChunks() -> [String] {
        var chunks = sentence
            .components(separatedBy: targetText)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        chunks.insert(targetText, at: 1)
        
        return chunks
    }
    
    private var buttons: some View {
        HStack {
            Button("Start") {
                withAnimation {
                    width += targetWidth
                }
            }
            
            Button("Reset") {
                withAnimation {
                    width = 0
                }
            }
        }
    }
}

extension View {
    func highlight(_ width: CGFloat) -> some View {
        modifier(HighlightedModifier(width: width))
    }
}

struct HighlightedModifier: ViewModifier {
    let width: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(2)
            .background(
                GeometryReader {
                    geometry in
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.yellow)
                            .frame(
                                width: width <= geometry.size.width ? width : geometry.size.width,
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
