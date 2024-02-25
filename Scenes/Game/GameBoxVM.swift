import SwiftUI

final class GameBoxVM: ObservableObject {
    var stayEvent: (()->())
    var changeEvent: (()->())
    var chooseDoor1: (() ->())
    var chooseDoor2: (() ->())
    var chooseDoor3: (() ->())

    init(stayEvent: @escaping () -> Void,
         changeEvent: @escaping () -> Void,
         chooseDoor1: @escaping () -> Void,
         chooseDoor2: @escaping () -> Void,
         chooseDoor3: @escaping () -> Void) {
        self.stayEvent = stayEvent
        self.changeEvent = changeEvent
        self.chooseDoor1 = chooseDoor1
        self.chooseDoor2 = chooseDoor2
        self.chooseDoor3 = chooseDoor3
    }


}
