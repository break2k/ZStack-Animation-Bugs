//
//  ContentView.swift
//  ZStack-Animation-Bugs
//
//  Created by Vitalij Dadaschjanz on 23.09.21.
//

import SwiftUI

struct ContentView: View {
    @State var showsOverlay: Bool = false
    
    var body: some View {
        ZStack {
            Button("Show Overlay") {
                withAnimation {
                    showsOverlay = true
                }
            }
            
            if showsOverlay {
                OverlayView(isVisible: $showsOverlay) {
                    Color.yellow
                        .frame(width: 200, height: 200)
                }
            }
        }
    }
}

struct OverlayView<Content: View>: View {
    @Binding var isVisible: Bool
    @ViewBuilder var content: Content
    
    // Drawing Constants
    private let padding: CGFloat = 8.0

    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: padding) {
                Text("Overlay Title")
                
                content
                    .padding(EdgeInsets(top: 0, leading: padding * 2, bottom: padding * 4, trailing: padding * 2))
                    .background(Color.gray)
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            Color.black.opacity(0.5)
                .transition(.opacity)
                .onTapGesture {
                    isVisible = false
                }
        )
        .transition(.move(edge: .bottom)) // this works but ignores opacity transition
//        .transition(.move(edge: .bottom).combined(with: .opacity)) // this is not what i want
    }
}

