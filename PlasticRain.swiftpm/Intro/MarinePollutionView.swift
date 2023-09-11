//
//  RecycleView.swift
//  PlasticRain
//
//  Created by 한지석 on 2023/04/10.
//

import SwiftUI

struct MarinePollutionView: View {
    
    @State var count = 0
    @State var isAnimating = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("background1"),
                                    Color("background2")],
                           startPoint: .bottom,
                           endPoint: .top)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Image("marinePollution")
                    .offset(y: 20)
            }
            ForEach(0..<30) { index in
                let randomX = CGFloat.random(in: 0...(UIScreen.main.bounds.width - 100))
                let randomY = CGFloat.random(in: 0...(UIScreen.main.bounds.height - 100))
                Image("micro\(index % 10)")
                    .foregroundColor(.blue)
                    .position(x: randomX, y: randomY)
                    .animation(.linear(duration: 100).repeatForever(autoreverses: true), value: isAnimating)
                    .onAppear {
                        isAnimating = true
                    }
            }
                
            
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: CGFloat(20))
                        .foregroundColor(.white)
                        .frame(width: 435, height: 112)
                        .overlay {
                            Text("A huge amount of plastic is\nfloating in the ocean.")
                                .font(.system(size: 24, weight: .regular))
                                .foregroundColor(count == 0 ? .black : Color("stringHide"))
                                .multilineTextAlignment(.center)
                        }
                        .offset(x: 70, y: 120)
                    if count == 0 {
                        Button {
                            withAnimation {
                                count += 1
                            }
                        } label: {
                            Image("right")
                        }
                        .offset(x: 100, y: 120)
                    }
                    Spacer()
                }
                Spacer()
            }
            
            if count >= 1 {
                VStack {
                    HStack {
                        Spacer()
                        if count == 1 {
                            Button {
                                withAnimation {
                                    count += 1
                                }
                            } label: {
                                Image("down")
                            }
                            .offset(x: -200, y: 205)
                        }
                        RoundedRectangle(cornerRadius: CGFloat(20))
                            .foregroundColor(.white)
                            .frame(width: 500, height: 157)
                            .overlay {
                                Text("Plastic accumulated in the sea is not\ncompletely decomposed, but\ndecomposes into microplastics.")
                                    .font(.system(size: 24, weight: .regular))
                                    .foregroundColor(count == 1 ? .black : Color("stringHide"))
                                    .multilineTextAlignment(.center)
                            }
                            .offset(x: -180, y: 200)
                    }
                    
                    Spacer()
                }
            }
            
            if count >= 2 {
                VStack {
                    Spacer()
                    HStack {
                        RoundedRectangle(cornerRadius: CGFloat(20))
                            .foregroundColor(.white)
                            .frame(width: 500, height: 157)
                            .overlay {
                                Text("Plastic accumulated in the sea is not\ncompletely decomposed, but\ndecomposes into microplastics.")
                                    .font(.system(size: 24, weight: .regular))
                                    .foregroundColor(count == 2 ? .black : Color("stringHide"))
                                    .multilineTextAlignment(.center)
                            }
                            .offset(x: 130, y: -220)
                        if count == 2 {
                            Button {
                                withAnimation {
                                    count += 1
                                }
                            } label: {
                                Image("right")
                            }
                            .offset(x: 170, y: -220)
                        }
                        Spacer()
                    }
                }
            }
            
            if count >= 3 {
                VStack {
                    HStack {
                        RoundedRectangle(cornerRadius: CGFloat(20))
                            .foregroundColor(.white)
                            .frame(width: 500, height: 190)
                            .overlay {
                                Text("Eventually, humans ingest the\norganisms that have ingested the\nmicroplastics, which adversely\naffects their health.")
                                    .font(.system(size: 24, weight: .regular))
                                    .foregroundColor(count == 3 ? .black : Color("stringHide"))
                                    .multilineTextAlignment(.center)
                            }
                            .offset(x: 310, y: 60)
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink {
                            PlasticRainView()
                        } label: {
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color("lemon"), lineWidth: 3)
                                .frame(width: 125, height: 60)
                                .overlay {
                                    Text("Next")
                                        .font(.system(size: 24, weight: .medium))
                                        .foregroundColor(Color("lemon"))
                            }
                        }
                        .padding(.trailing, 60)
                        .padding(.bottom, 88)
                    }
                }
            }
            
            HStack {
                Spacer()
                Image("toggleOn")
                    .padding(.trailing, 25)
                    .offset(y: -45)
            }
            
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton()
            }
            
        }
    }
}

struct MarinePollution_previews: PreviewProvider {
    static var previews: some View {
        MarinePollutionView()
    }
}
