//
//  SwiftUIView.swift
//  
//
//  Created by Moyses Miranda do Vale Azevedo on 25/02/24.
//

import SwiftUI

struct HomePresentation: View {
    @State var selectedIntroduction: Int = 0
    @State var selectionGame: Int = 0

    var body: some View {
        switch selectionGame {
        case 0:
            firstDialog
        case 1:
            GameBoxPresentation()
        default:
            Text("fim")
        }
    }

    var firstDialog: some View {
        TabView(selection: $selectedIntroduction) {
            ForEach(0..<DataDialogues.firstScene.count, id: \.self) {index in
                Text(DataDialogues.firstScene[index].0)
                    .tag(index)
            }
            Button{
                selectionGame += 1
            }label: {
                LabelButtonCTA("Click for go in the lab")
                    .tag(DataDialogues.firstScene.count + 2)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(
            .page(backgroundDisplayMode: .always)
        )
    }
}

#Preview {
    HomePresentation()
}
