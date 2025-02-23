//
//  TitleView.swift
//  ViewsAndModifiers
//
//  Created by Vijay Sharma on 06/02/25.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .titleMod()
            
    }
}
struct TileModModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .bold()
    }
}
extension View {
    func titleMod() -> some View {
        modifier(TileModModifier())
    }
}

#Preview {
    TitleView()
}
