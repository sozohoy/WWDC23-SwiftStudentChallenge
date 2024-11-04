//
//  SwiftUIView.swift
//  
//
//  Created by 한지석 on 2023/04/10.
//

import SwiftUI

struct InitialView: View {
  
  @State var isPresented = false
  
  var body: some View {
    NavigationView {
      ZStack {
        LinearGradient(
          colors: [
            Color("background1"),
            Color("background2")
          ],
          startPoint: .bottom,
          endPoint: .top
        )
        .edgesIgnoringSafeArea(.all)
        VStack {
          Image("title1")
            .offset(y: 100)
          Text("It is time to reduce the use of plastic.")
            .offset(y: 215)
            .foregroundColor(Color("lemon"))
            .font(.system(size: 36))
          NavigationLink(destination: DescriptionView(), isActive: $isPresented) {
            Text("Tap to investigate")
              .foregroundColor(Color("lemon"))
              .font(.system(size: 36))
              .frame(width: 340, height: 61)
              .overlay {
                RoundedRectangle(cornerRadius: 30)
                  .stroke(Color("lemon"), lineWidth: 3)
              }
            
          }
          .offset(y: 247)
          Spacer()
          Image("title2")
            .padding(.bottom, 70)
        }
      }
      .ignoresSafeArea()
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct InitialView_Priviews: PreviewProvider {
  static var previews: some View {
    InitialView()
  }
}

struct CustomBackButton: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Button {
      self.dismiss()
    } label: {
      Image(systemName: "arrow.left")
        .foregroundColor(Color("lemon"))
        .frame(width: 30, height: 30)
    }
  }
}
