//
//  SwiftUIView.swift
//  
//
//  Created by 한지석 on 2023/04/10.
//

import SwiftUI

struct DescriptionView: View {
    
    @State var rectangles: [DescriptionRectangle] = [
        DescriptionRectangle(text: "1. Tap the line at the top of the screen.      \n    Then the plastic will drop.")
    ]
    // Tap the line at the top of the screen.
    // Tap anywhere on the top of the screen.
    
    let description = ["2. Try to tap and drop so the moving\n     recycling basket can catch the plastic!",
                       "Tap to start!" ]
    @State var index = 0
    @State var isPresented = false
    @State var textAnimate: Bool = false
    @State var tapAnimate: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                LinearGradient(colors: [Color("background1"),
                                        Color("background2")],
                               startPoint: .bottom,
                               endPoint: .top)
                .edgesIgnoringSafeArea(.all)
                .gesture(TapGesture().onEnded({ _ in
                    if index < 2 {
                        withAnimation {
                            rectangles.append(DescriptionRectangle(text: description[index]))
                        }
                        self.index += 1
                    } else {
                        self.isPresented = true
                    }
                }))
                .background {
                    NavigationLink(destination: GameView(), isActive: $isPresented) {
                        EmptyView()
                    }
                    .hidden()
                }
                VStack {
                    //MARK: V - 1
                    HStack {
                        Spacer()
                        Image("tap")
                            .offset(y: 100)
                            .padding(.trailing, 500)
                            .opacity(tapAnimate ? 1 : 0)
                            .onAppear(perform: tapAnimation)
                    }
                    Rectangle()
                        .frame(width: proxy.size.width, height: 5)
                        .padding(.top, 35)
                        .foregroundColor(Color("lemon"))
                    HStack {
                        Text("How to play")
                            .font(.system(size: 35, weight: .medium))
                            .foregroundColor(Color("lemon"))
                            .padding(.leading, 36)
                        Spacer()
                        Text("10/10")
                            .font(.system(size: 35, weight: .medium))
                            .foregroundColor(Color("lemon"))
                            .padding(.trailing, 36)
                    }
                    Spacer()
                    //MARK: V - 2
                    VStack() {
                        ForEach(rectangles, id: \.id) { rectangle in
                            HStack {
                                rectangle
                                Spacer()
                            }
                            .padding(.top, 15)
                            
                        }
                        Spacer()
                    }
                    .frame(height: CGFloat(545))
                    Spacer()
                    //MARK: V - 3
                    
                    HStack {
                        Text("Restart")
                            .font(.system(size: 35, weight: .medium))
                            .foregroundColor(Color("lemon"))
                            .padding(.leading, 36)
                            .offset(y: 20)
                        Spacer()
                        Spacer()
                        Text("Successfully Recycled 0%")
                            .font(.system(size: 35, weight: .medium))
                            .foregroundColor(Color("lemon"))
                            .padding(.trailing, 36)
                            .offset(y: 20)
                    }
                    
                    Rectangle()
                        .frame(width: proxy.size.width, height: 155)
                        .foregroundColor(Color("bottomColor"))
                        .offset(y: 20)
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()

                        Text("TAP THE SCREEN\nTO MOVE ON\n")
                            .multilineTextAlignment(.center)
                            .offset(y: 110)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.trailing, 180)
                            .shadow(color: .black, radius: 5)
                    }
                    Spacer()
                    Image("basket")
                        .padding(.bottom, 100)
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton()
            }
        }
    }
    
    
//    func textAnimation() {
//        guard !textAnimate else { return }
//        DispatchQueue.main.asyncAfter(deadline: .now() +  0.5) {
//            withAnimation(
//                Animation
//                    .easeInOut(duration: 2.0)
//                    .repeatForever()
//            ) {
//                textAnimate.toggle()
//            }
//        }
//    }
//
    func tapAnimation() {
        guard !tapAnimate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(
                Animation
                    .easeInOut(duration: 1.0)
                    .repeatForever()
            ) {
                tapAnimate.toggle()
            }
        }
    }
    
    
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView()
    }
}
