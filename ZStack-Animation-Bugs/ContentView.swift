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
//                withAnimation(.easeIn) { // aint working
                withAnimation(.easeIn) {
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
        ZStack {
            if isVisible {
                Color.black.opacity(0.5)
                    .onTapGesture {
                        isVisible = false
                    }
                    .transition(.opacity)
            }
        }
        
        VStack {
            Spacer()
            
            VStack(spacing: padding) {
                Text("Overlay Title")
                
                content
                    .padding(EdgeInsets(top: 0, leading: padding * 2, bottom: padding * 4, trailing: padding * 2))
                    .background(Color.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .transition(.move(edge: .bottom))
    }
}

