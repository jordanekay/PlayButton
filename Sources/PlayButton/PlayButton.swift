public import SwiftUI

public struct PlayButton {
    private let isEnabled: Bool

    @Binding private var isPlaying: Bool

    public init(
        isPlaying: Binding<Bool>,
        isEnabled: Bool = true
    ) {
        self.isEnabled = isEnabled

        _isPlaying = isPlaying
    }
}

// MARK: -
extension PlayButton: View {
    public var body: some View {
        let shape = PlayPauseShape(isPlaying: isPlaying)
            .contentShape(Rectangle())
            .accessibilityAction(.default, toggle)
            .accessibility(addTraits: .isButton)

        if isEnabled {
            shape
                .animation(.easeInOut(duration: 0.3), value: isPlaying)
                .onTapGesture(perform: toggle)
        } else {
            shape
                .opacity(0.3)
                .disabled(true)
        }
    }
}

// MARK: -
private extension PlayButton {
    func toggle() {
        isPlaying.toggle()
    }
}
