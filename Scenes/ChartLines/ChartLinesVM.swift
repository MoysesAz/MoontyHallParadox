import Foundation

final class ChartLinesVM: ObservableObject {
    @Published var data: [ChoiseValues] = []
    @Published var stayMoves = 0
    @Published var stayVictories = 0

    public func play() {
        
    }
    //                moves += 1
    //                victores += Int.random(in: 0...1)
    //                let newValue = ChoiseValues(choise: victores, moves: moves)
    //                data.append(newValue)
}
