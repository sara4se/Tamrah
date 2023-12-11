//
//  Onboearding.swift
//  AItTestImageTWQ
//
//  Created by Sara Alhumidi on 19/11/1444 AH.
//

import SwiftUI
struct OnboradingView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @Binding var shouldShoOnboarding: Bool
//    @State private var currentStep = 0
    var body: some View {
        GeometryReader { geo in
            ZStack{
                Image("background")
                    .resizable().ignoresSafeArea()
//                Image("tamrah")
//                    .resizable()
//                    .frame(width: 189.2, height: 239)
//                    .edgesIgnoringSafeArea(.all)
//                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
//                    .opacity(1.0)
//        
                VStack{
                    HStack{
                        Spacer()
                        Button(action: {
                            shouldShoOnboarding.toggle()
                        }, label: {
                            Text(LocalizedStringKey("Skip"))
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                                .kerning(1.2)
                        }).padding(.trailing)
                        Spacer()
                            .padding(.trailing)
                        
                        
                    }.padding()
                        .foregroundColor(.black)
                    Spacer()
                    
                    
                    
                    TabView {
                        
                        PageView(
                            title: "AI classifing",
                            subtitle: "This app uses AI to classify Dates Type.",
                            imageName: "tamrah",
                            //ImageName2: "Group",
                            showsDismisButton: false,
                            shouldShoOnboarding: $shouldShoOnboarding
                        )
                        PageView(
                            title: "Simple & fast",
                            subtitle: "choose an image or capture a dates then wait for predictions",
                            imageName: "tamrah",
                            //ImageName2: "Group",
                            showsDismisButton: false,
                            shouldShoOnboarding: $shouldShoOnboarding
                        )
                        
                    
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                }
            }
        }
    }
    
}

struct PageView: View {
    let title: String
    let subtitle: String
    let imageName: String
//    let ImageName2: String
    let showsDismisButton: Bool
    @Binding var shouldShoOnboarding: Bool
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding()
            Text(title)
                .foregroundColor(Color.black)
                .font(.system(size: 32))
                .multilineTextAlignment(.center)
                .padding()
            
            Text(subtitle)
                .font(.system(size: 24))
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                .padding()
            
            
            if showsDismisButton{
                Button(action: {
                    shouldShoOnboarding.toggle()
                }, label: {
                    Text("Get Started")
                        .bold()
                        .foregroundColor(Color.black)
                        .frame(width: 281, height: 41)
                        .background(Color("Green"))
                        .cornerRadius(6)
                })
            }
            
        }
    }
}

struct OnboradingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboradingView( shouldShoOnboarding: .constant(true))
    }
}
