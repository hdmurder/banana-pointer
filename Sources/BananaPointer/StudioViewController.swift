import AppKit

final class StudioViewController: NSViewController {
    private let store: StudioStore
    private let bananaView: BananaControlView
    private let meterView = MeterBridgeView()
    private let outputsStack = NSStackView()
    private var observations: [NSKeyValueObservation] = []

    init(store: StudioStore) {
        self.store = store
        self.bananaView = BananaControlView(store: store)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        build()
        bind()
        reloadOutputs()
    }

    private func build() {
        let root = NSStackView()
        root.orientation = .horizontal
        root.spacing = 0
        root.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(root)
        root.addArrangedSubview(sidebar())
        root.addArrangedSubview(center())
        root.addArrangedSubview(inspector())
        NSLayoutConstraint.activate([
            root.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            root.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            root.topAnchor.constraint(equalTo: view.topAnchor),
            root.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func sidebar() -> NSView {
        let box = NSVisualEffectView()
        box.material = .sidebar
        let stack = VStack(in: box, inset: 20)
        stack.addArrangedSubview(Label("Banana Pointer", 22, .semibold))
        stack.addArrangedSubview(Label("Control Room\nOutputs\nCues\nMIDI\nSnapshots", 14, .regular, .secondaryLabelColor, true))
        return box.sized(width: 220)
    }

    private func center() -> NSView {
        let box = NSView()
        let stack = VStack(in: box, inset: 26)
        stack.addArrangedSubview(Label("Control Room", 30, .semibold))
        stack.addArrangedSubview(Label("Demo monitor surface with banana master control, meters, outputs, snapshots, and MIDI Learn.", 13, .regular, .secondaryLabelColor, true))
        stack.addArrangedSubview(meterView)
        let row = NSStackView()
        row.orientation = .horizontal
        row.spacing = 28
        row.addArrangedSubview(bananaView)
        row.addArrangedSubview(controlButtons())
        stack.addArrangedSubview(row)
        stack.addArrangedSubview(Label("Outputs", 18, .semibold))
        outputsStack.orientation = .horizontal
        outputsStack.spacing = 12
        stack.addArrangedSubview(outputsStack)
        return box
    }

    private func inspector() -> NSView {
        let box = NSVisualEffectView()
        box.material = .contentBackground
        let stack = VStack(in: box, inset: 20)
        stack.addArrangedSubview(Label("Inspector", 22, .semibold))
        stack.addArrangedSubview(Label("Device: Audient iD44\nMode: Demo\nMIDI Learn: Command+L\nNext: Core Audio + Core MIDI services", 13, .regular, .secondaryLabelColor, true))
        return box.sized(width: 300)
    }

    private func controlButtons() -> NSView {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.spacing = 10
        for rowItems in [["Dim", "Cut", "Mono"], ["Polarity", "Sub", "Talkback"], ["MIDI Learn", "Snapshot", "+ Cue"]] {
            let row = NSStackView()
            row.orientation = .horizontal
            row.spacing = 10
            for title in rowItems {
                let button = NSButton(title: title, target: self, action: action(for: title))
                button.bezelStyle = .rounded
                row.addArrangedSubview(button)
            }
            stack.addArrangedSubview(row)
        }
        return stack
    }

    private func action(for title: String) -> Selector? {
        switch title {
        case "Dim": #selector(toggleDim)
        case "Cut": #selector(toggleCut)
        case "Mono": #selector(toggleMono)
        case "MIDI Learn": #selector(toggleMIDILearn)
        case "Snapshot": #selector(newSnapshot)
        case "+ Cue": #selector(addCue)
        default: #selector(noop)
        }
    }

    private func bind() {
        observations = [
            store.observe(\.masterLevel, options: [.new]) { [weak self] _, _ in self?.bananaView.needsDisplay = true },
            store.observe(\.meterSeed, options: [.new]) { [weak self] store, _ in self?.meterView.update(seed: store.meterSeed, cut: store.isCut) },
            store.observe(\.isMIDILearnEnabled, options: [.new]) { [weak self] _, _ in self?.bananaView.needsDisplay = true }
        ]
        NotificationCenter.default.addObserver(forName: .studioStoreChanged, object: store, queue: .main) { [weak self] _ in
            self?.reloadOutputs()
        }
    }

    private func reloadOutputs() {
        outputsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        store.outputs.forEach { outputsStack.addArrangedSubview(OutputCardView(output: $0)) }
    }

    @objc private func toggleDim() { store.isDimmed.toggle() }
    @objc private func toggleCut() { store.isCut.toggle() }
    @objc private func toggleMono() { store.isMono.toggle() }
    @objc private func toggleMIDILearn() { store.isMIDILearnEnabled.toggle() }
    @objc private func newSnapshot() { store.createSnapshot() }
    @objc private func addCue() { store.addCueOutput() }
    @objc private func noop() {}
}
