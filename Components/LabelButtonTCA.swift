import SwiftUI

struct LabelButtonCTA: View {
    private let nameButton: String
    private let color: Color

    init(_ nameButton: String, color: Color = .blue) {
        self.nameButton = nameButton
        self.color = color
    }

    var body: some View {
        Text(nameButton)
            .bold()
            .frame(width: 200, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(color)
            )
            .foregroundColor(.white)
    }
}

#Preview {
    LabelButtonCTA("teste", color: .pink)
}
