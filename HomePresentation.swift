import SwiftUI
import SpriteKit

struct HomePresentation: View {
    var scene: SKScene {
        let scene = BoxGame()
        scene.scaleMode = .resizeFill
        return scene
    }

    var body: some View {
            GeometryReader { frame in
                ZStack{
                    SpriteView(scene: scene)
                        .frame(width: frame.size.width, height: frame.size.height, alignment: .center)
                    VStack {
                        Spacer()
                        HStack{
                            Button {
                                print("Change")
                            } label: {
                                LabelButtonCTA("Change")
                            }
                            Button {
                                print("Choise")
                            } label: {
                                LabelButtonCTA("Choise")
                            }
                        }
                        .padding(.bottom, 60)
                    }
                }
            }
        }
}

#Preview {
    HomePresentation()
}
