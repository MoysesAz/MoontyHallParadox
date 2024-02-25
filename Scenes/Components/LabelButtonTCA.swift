import SwiftUI

struct LabelButtonCTA: View {
    private let nameButton: String

    init(_ nameButton: String) {
        self.nameButton = nameButton
    }

    var body: some View {
        Text(nameButton)
            .bold()
            .frame(width: 200, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(.red)
            )
            .foregroundColor(.white)
    }
}

#Preview {
    LabelButtonCTA("teste")
}
