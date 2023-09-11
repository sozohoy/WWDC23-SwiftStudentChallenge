//
//  SoilPollutionView.swift
//  PlasticRain
//
//  Created by 한지석 on 2023/04/10.
//

import SwiftUI

struct SoilPollutionView: View {
    
    @State var count = 0
    @State var textAnimate: Bool = false
    @State var isAnimating: Bool = false
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("background1"),
                                    Color("background2")],
                           startPoint: .bottom,
                           endPoint: .top)
            .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                Spacer()
//                ZStack {
                Image("soilPollution")
//                    Text("LEACHATE")
//                        .font(.system(size: 55, weight: .black))
//                        .foregroundColor(Color("lemon"))
//                        .offset(x: -60, y: -90)
//                        .shadow(color: .black, radius: textAnimate ? 5 : 20)
//                        .scaleEffect(textAnimate ? 0.95 : 1.00)
//                        .onAppear(perform: textAnimation)
//                }

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
            HStack {
                Spacer()
                Image("toggleOn")
                    .padding(.trailing, 25)
            }
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: CGFloat(20))
                        .foregroundColor(.white)
                        .frame(width: 435, height: 112)
                        .overlay {
                            Text("Plastic buried in soil takes\nhundered of years to decompose.")
                                .font(.system(size: 24, weight: .regular))
                                .foregroundColor(count == 0 ? .black : Color("stringHide"))
                                .multilineTextAlignment(.center)
                        }
                        .offset(x: 63, y: 189)
                    if count == 0 {
                        Button {
                            isAnimating = true
                            withAnimation {
                                count += 1
                            }
                        } label: {
                            Image("right")
                        }
                        .offset(x: 90, y: 189)
                    }
                    Spacer()
                }
                Spacer()
            }
            
            if count >= 1 {
                VStack {
                    HStack {
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: CGFloat(20))
                                .foregroundColor(.white)
                                .frame(width: 500, height: 216)
                                .overlay {
                                    Text("During the decomposition of various\nwastes and plastics, leachate is\n formed when it rains or is combined\nwith groundwater, and leachate is\n discharged into the soil.")
                                            .font(.system(size: 24, weight: .regular))
                                            .foregroundColor(count == 1 ? .black : Color("stringHide"))
                                            .multilineTextAlignment(.center)
                                            .padding(20)
                                        
                                }
                                .offset(x: -120, y: 271)
                            if count == 1 {
                                Button {
                                    isAnimating = true
                                    withAnimation {
                                        count += 1
                                    }
                                } label: {
                                    Image("down")
                                }
                                .offset(x: -110, y: 295)
                            }
                        }
                    }
                    Spacer()
                }
            }
            
            if count >= 2 {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if count == 2 {
                            Button {
                                isAnimating = true
                                withAnimation {
                                    count += 1
                                }
                            } label: {
                                Image("left")
                            }
                            .offset(x: -130, y: -245)
                        }
                        RoundedRectangle(cornerRadius: CGFloat(20))
                            .foregroundColor(.white)
                            .frame(width: 500, height: 170)
                            .overlay {
                                Text("Leachate is composed of various\ncontaminants and harms the health\nof the entire ecosystem.")
                                        .font(.system(size: 24, weight: .regular))
                                        .foregroundColor(count == 2 ? .black : Color("stringHide"))
                                        .multilineTextAlignment(.center)
                                        .padding(20)
                                    
                            }
                            .offset(x: -100, y: -240)
                    }
                }
            }
            
            if count >= 3 {
                VStack {
                    Spacer()
                    HStack {
                        RoundedRectangle(cornerRadius: CGFloat(20))
                            .foregroundColor(.white)
                            .frame(width: 500, height: 170)
                            .overlay {
                                Text("In humans, it causes respiratory\nproblems, neurological damage,\nand even cancer.")
                                        .font(.system(size: 24, weight: .regular))
                                        .multilineTextAlignment(.center)
                                        .padding(20)
                            }
                            .offset(x: 60, y: -100)
                        Spacer()
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink {
                            MarinePollutionView()
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
            
            
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton()
            }
        }
        
    }
    
    func textAnimation() {
        guard !textAnimate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 1.0)
                    .repeatForever()
            ) {
                textAnimate.toggle()
            }
        }
    }
}


struct SoilPollution_previews: PreviewProvider {
    static var previews: some View {
        SoilPollutionView()
    }
}
