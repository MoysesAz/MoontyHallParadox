//
//  SwiftUIView.swift
//  
//
//  Created by Moyses Miranda do Vale Azevedo on 25/02/24.
//

import SwiftUI
import Charts

struct ChartLines: View {
    @State var data: [ChoiseValues] = []

    var body: some View {
        VStack {
            Chart {
                ForEach(0..<data.count, id: \.self) {index in
                    LineMark(
                        x: PlottableValue.value("Vitorias", data[index].choise),
                        y: PlottableValue.value("Jogadas", data[index].moves)
                    )
                    .foregroundStyle(.red)
                }
            }
            .frame(height: 200)
        }
    }
}

#Preview {
    ChartLines()
}
