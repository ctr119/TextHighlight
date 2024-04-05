import SwiftUI

struct ContentView: View {
    @State private var width: CGFloat = 0
    private let targetWidth: CGFloat = 50
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(
"""
Lorem ipsum dolor sit amet
"""
            )
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
            
            Spacer()
            buttons
        }
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

#Preview {
    ContentView()
}
