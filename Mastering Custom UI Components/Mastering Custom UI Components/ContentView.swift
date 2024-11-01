//
//  ContentView.swift
//  Mastering Custom UI Components
//
//  Created by Balaji A on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CustomButtonView()
                .padding()
            ProgressBarView()
                .padding()
            DraggableCircleView()
                .padding()
        }
    }
}

// MARK: - ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
    }
}


struct CustomButtonView: View {
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button(action: {
            // Button action
            print("Button pressed!")
        }) {
            Text("Custom Button")
                .font(.headline)
                .padding()
                .background(isPressed ? .green : .blue)
                .foregroundColor(isPressed ? .red : .white)
                .cornerRadius(10)
                .scaleEffect(isPressed ? 2.0 : 1.0) // Larger scale effect for visibility
                .animation(.spring(), value: isPressed) // Smooth spring animation
        }
        .onLongPressGesture(minimumDuration: 0.5, pressing: { pressing in
            self.isPressed = pressing // Change state when Long pressing
        }) {
            print("Long press ended") // Optional action for long press release
        }
    }
}

struct ProgressBarView: View {
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 20)
                    .foregroundColor(Color.gray.opacity(0.5))
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: progress * 300, height: 20)
                    .foregroundColor(.blue)
                    .animation(.easeInOut(duration: 1), value: progress)
            }
            
            // Button label changes depending on progress
            Button(progress < 1.0 ? "Increase Progress" : "RESET Progress") {
                if progress < 1.0 {
                    progress += 0.5
                } else {
                    progress = 0.0 // Reset progress when full
                }
            }
            .padding(.top, 20)
        }
    }
}

struct DraggableCircleView: View {
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        Circle()
            .fill(Color.orange)
            .frame(width: 100, height: 100)
            .offset(dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        dragOffset = gesture.translation
                    }
                    .onEnded { _ in
                        dragOffset = .zero // Reset position when drag ends
                    }
            )
            .animation(.spring(), value: dragOffset)
    }
}
