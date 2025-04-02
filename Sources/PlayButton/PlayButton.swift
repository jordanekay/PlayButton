public import SwiftUI

public struct PlayButton {
    @Binding private var isPlaying: Bool
    @Environment(\.isEnabled) private var isEnabled

    public init(isPlaying: Binding<Bool>) {
        _isPlaying = isPlaying
    }
}

// MARK: -
extension PlayButton: View {
    public var body: some View {
        PlayPauseShape(isPlaying: isPlaying)
            .contentShape(Rectangle())
            .opacity(isEnabled ? 1 : 0.3)
            .animation(.easeInOut(duration: 0.3), value: isPlaying)
            .onTapGesture(perform: toggle)
            .accessibilityAction(.default, toggle)
            .accessibility(addTraits: .isButton)
    }
}

// MARK: -
private extension PlayButton {
    func toggle() {
        isPlaying.toggle()
    }
}
