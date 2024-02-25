import SwiftUI
import SpriteKit

struct GameBoxPresentation: View {
    @ObservedObject var vm: GameBoxVM
    let game = BoxGame()
    var scene: BoxGame

    init() {
        scene = game
        scene.scaleMode = .resizeFill
        self.vm = .init(stayEvent: game.stayWithDoor,
                        changeEvent: game.changeDoor,
                        chooseDoor1: game.chooseDoor1,
                        chooseDoor2: game.chooseDoor2,
                        chooseDoor3: game.chooseDoor3)
    }

    var body: some View {
            GeometryReader { frame in
                ZStack{
                    VStack {
                        SpriteView(scene: scene)
                            .frame(width: frame.size.width, height: frame.size.height)
                    }
                    VStack {
                        Spacer()
                        Spacer()
                        ChartLines(data: dataMock)
                            .padding(.bottom, 150)
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        choiseDoor
                        moontyHall
                        .padding(.bottom, 60)
                    }
                }
            }
        }

    
    var choiseDoor: some View {
        HStack {
            Button {
                vm.chooseDoor1()
            } label: {
                LabelButtonCTA("Door 1", color: .green)
            }
            Button {
                vm.chooseDoor2()
            } label: {
                LabelButtonCTA("Door 2", color: .green)
            }
            Button {
                vm.chooseDoor3()
            } label: {
                LabelButtonCTA("Door 3", color: .green)
            }
        }
    }

    var moontyHall: some View {
        HStack{
            Button {
                vm.stayEvent()
            } label: {
                LabelButtonCTA("Stay With The Door", color: .blue)
            }
            Button {
                vm.changeEvent()
            } label: {
                LabelButtonCTA("Choise")
            }
        }

    }
}

#Preview {
    GameBoxPresentation()
}
