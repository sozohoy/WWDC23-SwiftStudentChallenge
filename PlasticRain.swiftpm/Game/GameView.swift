import SwiftUI
import SpriteKit

struct GameView: View {

  @State var completeIsPresented = false
  @State var recycleCount = 0
  @State var touchCount = 0

  var gameScene: GameScene {
    GameScene(recycleCount: $recycleCount,
              touchCount: $touchCount,
              completeIsPresented: $completeIsPresented)
  }

  var scene: SKScene {
    let scene = gameScene
    scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    scene.scaleMode = .fill
    scene.backgroundColor = .clear
    return scene
  }

  var body: some View {
    GeometryReader { proxy in
      ZStack {
        LinearGradient(colors: [Color("background1"),
                                Color("background2")],
                       startPoint: .bottom,
                       endPoint: .top)
        .edgesIgnoringSafeArea(.all)
        SpriteView(scene: scene)
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
          .ignoresSafeArea()
        VStack {
          //MARK: V - 1
          Rectangle()
            .frame(width: proxy.size.width, height: 5)
            .padding(.top, 150)
            .foregroundColor(Color("lemon"))
          HStack {
            Spacer()
            Text("\(10 - touchCount)/10")
              .font(.system(size: 35, weight: .medium))
              .foregroundColor(Color("lemon"))
              .padding(.trailing, 36)
          }
          Spacer()
          Spacer()
          HStack {
            Button {
              recycleCount = 0
              touchCount = 0
            } label: {
              Text("Restart")
                .font(.system(size: 35, weight: .medium))
                .foregroundColor(Color("lemon"))
                .padding(.leading, 36)
            }
            Spacer()
            Spacer()
            Text("Successfully Recycled \(recycleCount * 10)%")
              .font(.system(size: 35, weight: .medium))
              .foregroundColor(Color("lemon"))
              .padding(.trailing, 36)
          }
          Rectangle()
            .frame(width: proxy.size.width, height: 155)
            .foregroundColor(Color("bottomColor"))
        }
        if completeIsPresented {
          Color.black.opacity(0.4)
          CompleteView(completeIsPresented: $completeIsPresented,
                       recycleCount: $recycleCount,
                       touchCount: $touchCount)
          .frame(width: 400, height: 400)
          .transition(.opacity)
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
}

struct VerticalToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    VStack(alignment: .trailing) {
      HStack {
        Spacer()
        configuration.label
        Button {
          withAnimation(.linear) {
            configuration.isOn.toggle()
          }
        } label: {
          RoundedRectangle(cornerRadius: 30)
            .strokeBorder(Color("lemon"), lineWidth: 3)
            .frame(width: 47, height: 105)
            .overlay(content: {
              VStack {
                if configuration.isOn {
                  Text("On")
                    .foregroundColor(Color("lemon"))
                    .font(.system(size: 20, weight: .medium))
                }
                Circle()
                  .fill(Color("lemon"))
                  .frame(width: 35, height: 36)
                  .offset(y: configuration.isOn ? 8 : -9)
                if !configuration.isOn {
                  Text("Off")
                    .foregroundColor(Color("lemon"))
                    .font(.system(size: 20, weight: .medium))
                }
              }
            })
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
        }
      }
    }
  }
}


struct GameView_Previews: PreviewProvider {
  static var previews: some View {
    GameView()
  }
}

struct CompleteView: View {

  @Binding var completeIsPresented: Bool
  @Binding var recycleCount: Int
  @Binding var touchCount: Int
  @State var nextIsPresented: Bool = false

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: CGFloat(20))
        .foregroundColor(.white)
        .frame(width: 420, height: 430)
        .overlay {
          VStack {
            Text("COMPLETE")
              .font(.system(size: 36, weight: .regular))
              .padding(.top, 45)
            Text("Successfully\nRecycled")
              .foregroundColor(Color("background2"))
              .font(.system(size: 24, weight: .regular))
              .multilineTextAlignment(.center)
              .offset(y: 20)

            HStack(spacing: 0) {
              Rectangle()
                .frame(width: 25 * CGFloat(recycleCount), height: 44)
                .foregroundColor(Color("percent1"))
              Rectangle()
                .frame(width: 25 * CGFloat(10 - recycleCount), height: 44)
                .foregroundColor(Color("percent2"))
              Text("\(recycleCount * 10)%")
                .font(.system(size: 36, weight: .regular))
                .padding(.leading, 10)
            }
            .padding(.top, 50)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            Spacer()
            HStack {
              Button {
                completeIsPresented.toggle()
                touchCount = 0
                recycleCount = 0
              } label: {
                RoundedRectangle(cornerRadius: CGFloat(100))
                  .stroke(Color("restart"), lineWidth: 3)
                  .frame(width: 125, height: 60)
                  .overlay {
                    Text("Restart")
                      .font(.system(size: 24, weight: .medium))
                      .foregroundColor(Color("restart"))
                  }
              }
              .padding(.leading, 42)
              Spacer()
              Button {
                nextIsPresented.toggle()
              } label: {
                RoundedRectangle(cornerRadius: CGFloat(100))
                  .stroke(Color("next"), lineWidth: 3)
                  .frame(width: 125, height: 60)
                  .overlay {
                    Text("Next")
                      .font(.system(size: 24, weight: .medium))
                      .foregroundColor(Color("next"))
                  }
                  .padding(.trailing, 42)
              }
            }
            .padding(.bottom, 40)
          }
        }
      if nextIsPresented {
        CompleteNextView(nextIsPresented: $nextIsPresented)
      }
    }
  }
}

struct CompleteNextView: View {

  @Binding var nextIsPresented: Bool

  var body: some View {
    RoundedRectangle(cornerRadius: CGFloat(20))
      .frame(width: 420, height: 430)
      .overlay {
        VStack {
          HStack {
            Button {
              nextIsPresented.toggle()
            } label: {
              Image(systemName: "arrow.backward")
                .foregroundColor(Color("lemon"))
            }
            .padding(.leading, 30)
            Spacer()
          }
          Text("Over the past 20 years, while\nplastic production and waste\nhave more than doubled, only \nabout 9% is being recycled.")
            .multilineTextAlignment(.center)
            .font(.system(size: 24, weight: .regular))
            .foregroundColor(Color("lemon"))
            .padding(.top, 20)
            .padding(.leading, 25)
            .padding(.trailing, 25)
          Text("What happened to the\nrest of the plastic?")
            .multilineTextAlignment(.center)
            .font(.system(size: 28, weight: .medium))
            .foregroundColor(Color("lemon"))
            .offset(y: 35)
          NavigationLink {
            SoilPollutionView()
          } label: {
            RoundedRectangle(cornerRadius: CGFloat(100))
              .stroke(Color("lemon"), lineWidth: 3)
              .frame(width: 125, height: 60)
              .overlay {
                Text("Next")
                  .font(.system(size: 24, weight: .medium))
                  .foregroundColor(Color("lemon"))
              }
          }
          .padding(.top, 60)
          .padding(.bottom, 0)
        }
      }
  }
}
