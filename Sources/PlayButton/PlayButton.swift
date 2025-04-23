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
        PlayPauseShape(isPlaying: isPlaying)
            .contentShape(Rectangle())
            .opacity(isEnabled ? 1 : 0.3)
            .animation(.easeInOut(duration: 0.3), value: isPlaying)
            .onTapGesture(perform: toggle)
            .disabled(!isEnabled)
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
