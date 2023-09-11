//
//  SwiftUIView.swift
//  
//
//  Created by 한지석 on 2023/04/17.
//

import SwiftUI

struct PlasticRainView: View {
    
    @State var toggleClicked: Bool = false
    @State var isAnimating = false
    @State var microNum = 1
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("background1"),
                                    Color("background2")],
                           startPoint: .bottom,
                           endPoint: .top)
            .edgesIgnoringSafeArea(.all)
            HStack {
                Spacer()
                Button {
                    toggleClicked.toggle()
                } label: {
                    Image("toggleOn")
                }
                .padding(.trailing, 25)
            }

            VStack() {
                Spacer()
                Image("plasticRain")
                    .offset(y: 20)
            }
            ForEach(0..<80) { index in
                let randomX = CGFloat.random(in: 0...(UIScreen.main.bounds.width - 100))
                let randomY = CGFloat.random(in: 0...(UIScreen.main.bounds.height - 100))
                Image("micro\(index % 10)")
                    .foregroundColor(.blue)
                    .position(x: randomX, y: randomY)
                    .animation(.linear(duration: 20).repeatForever(autoreverses: true), value: isAnimating)
                    .onAppear {
                        isAnimating = true
                    }
            }
            
            if toggleClicked {
                Color.black.opacity(0.4)
                    .onTapGesture {
                        toggleClicked.toggle()
                    }
                PlasticTabView(toggleClicked: $toggleClicked)
                    .transition(.opacity)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton()
            }
        }
    }
}

struct PlaticRain_previews: PreviewProvider {
    static var previews: some View {
        PlasticRainView()
    }
}

struct PlasticTabView: View {
    
    @Binding var toggleClicked: Bool
    
    var body: some View {
        VStack {
            TabView {
                FirstTab(toggleClicked: $toggleClicked)
                SecondTab(toggleClicked: $toggleClicked)
                ThirdTab(toggleClicked: $toggleClicked)
                FinalTab(toggleClicked: $toggleClicked)
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(width: 420, height: 430)
        }
    }
}

struct FirstTab: View {
    
    @Binding var toggleClicked: Bool

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 420, height: 430)
                .foregroundColor(.black)
                .overlay {
                    VStack {
                        Image("firstTab")
                        Spacer()
                    }
                    .offset(y: 45)
                }
        }
    }
}

struct SecondTab: View {
    
    @Binding var toggleClicked: Bool

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 420, height: 430)
                .foregroundColor(.black)
                .overlay {
                    VStack {
                        Image("secondTab")
                        Spacer()
                    }
                    .offset(y: 45)
                }
        }
    }
}

struct ThirdTab: View {
    
    @Binding var toggleClicked: Bool

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 420, height: 430)
                .foregroundColor(.black)
                .overlay {
                    VStack {
                        Image("thirdTab")
                        Spacer()
                    }
                    .offset(y: 45)
                }
        }
        
    }
}

struct FinalTab: View {
    
    @Binding var toggleClicked: Bool

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 420, height: 430)
                .foregroundColor(.black)
                .overlay {
                    Image("finalTab")
            }
        }
    }
}
