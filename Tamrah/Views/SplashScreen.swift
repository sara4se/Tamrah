//
//  SplashScreen.swift
//  AItTestImageTWQ
//
//  Created by Sara Alhumidi on 19/11/1444 AH.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isAnimationComplete = false
    @State private var isActive = false
    @AppStorage("_shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    
    var body: some View {
        ZStack {
                Image("background")
                    .resizable()
//                    .frame(width: 182, height: 183.22)
                    .scaleEffect(isAnimationComplete ? 2.0 : 1.0)
                    .opacity(isAnimationComplete ? 0.0 : 1.0)
                    .animation(.easeInOut(duration: 0.5)) //
            Image("tamrah")
                .resizable()
                .frame(width: 189.2, height: 239)
                .scaleEffect(isAnimationComplete ? 2.0 : 1.0)
                .opacity(isAnimationComplete ? 0.0 : 1.0)
                .animation(.easeInOut(duration: 0.5)) //
             }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            isAnimationComplete = true
                            isActive = true
                        }
                    }
                }
        
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $isActive) {
            if shouldShowOnboarding {
                OnboradingView(shouldShoOnboarding: $shouldShowOnboarding)
            } else {
                // If onboarding is not required, navigate to your desired view here
                // For example: ContentView()
                 ContentView()
            }
        }
    }
    func neonGradient() -> LinearGradient {
        let colors = [
            Color(hex: "#AB99FD"),
            Color(hex: "#87F1FB"),
            Color(hex: "#DBE2EB")
        ]
        return LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
