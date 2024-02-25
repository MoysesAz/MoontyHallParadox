import Foundation

struct ChangeValues: Identifiable {
    let change: Int
    let moves: Int

    var id: String = UUID().uuidString
}
