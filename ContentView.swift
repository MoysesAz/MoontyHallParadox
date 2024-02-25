import SwiftUI
import SpriteKit

struct ContentView: View {
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
                    Button {
                        print("Button pressed")
                    } label: {

                    }
                    .contentShape(Rectangle())
                }
            }
        }
}

#Preview {
    ContentView()
}
