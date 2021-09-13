//
//  AnimationUI.swift
//  AnimationUI
//
//  Created by Harry Yan on 28/08/21.
//

import SwiftUI

struct AnimationUI: View {
    @AnimatedState(
        value: false,
        animation: .spring()
    ) var scaleSquare
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AnimationUI_Previews: PreviewProvider {
    static var previews: some View {
        AnimationUI()
    }
}
