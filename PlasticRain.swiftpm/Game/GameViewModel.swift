//
//  SwiftUIView.swift
//  
//
//  Created by 한지석 on 2023/04/16.
//

import SwiftUI

class GameViewModel: ObservableObject {

    @Published var microPlasticHidden: Bool
    
    init(microPlasticHidden: Bool) {
        self.microPlasticHidden = microPlasticHidden
    }
    
    func microPlasticEvent() {
        if microPlasticHidden {
            
        }
    }
    
}


