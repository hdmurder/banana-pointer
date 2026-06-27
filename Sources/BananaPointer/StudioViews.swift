import AppKit

final class BananaControlView: NSView {
    private let store: StudioStore

    init(store: StudioStore) {
        self.store = store
        super.init(frame: NSRect(x: 0, y: 0, width: 300, height: 320))
        wantsLayer = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: NSSize { NSSize(width: 300, height: 320) }

    override func draw(_ dirtyRect: NSRect) {
        NSColor.controlBackgroundColor.withAlphaComponent(0.7).setFill()
        NSBezierPath(roundedRect: bounds.insetBy(dx: 12, dy: 12), xRadius: 18, yRadius: 18).fill()
        let path = NSBezierPath()
        let cx = bounds.midX
        let cy = bounds.midY + 24
        path.move(to: NSPoint(x: cx - 110, y: cy - 4))
        path.curve(to: NSPoint(x: cx + 110, y: cy + 58), controlPoint1: NSPoint(x: cx - 70, y: cy - 88), controlPoint2: NSPoint(x: cx + 80, y: cy - 48))
        path.curve(to: NSPoint(x: cx - 94, y: cy - 38), controlPoint1: NSPoint(x: cx + 72, y: cy - 8), controlPoint2: NSPoint(x: cx - 20, y: cy - 24))
        path.curve(to: NSPoint(x: cx - 110, y: cy - 4), controlPoint1: NSPoint(x: cx - 126, y: cy - 44), controlPoint2: NSPoint(x: cx - 134, y: cy - 10))
        path.close()
        let transform = NSAffineTransform()
        transform.translateX(by: cx, yBy: cy)
        transform.rotate(byDegrees: CGFloat(-45 + store.masterLevel * 270))
        transform.translateX(by: -cx, yBy: -cy)
        let rotated = transform.transform(path)
        NSColor(calibratedRed: 0.98, green: 0.72, blue: 0.16, alpha: 1).setFill()
        rotated.fill()
        NSColor(calibratedRed: 1.0, green: 0.94, blue: 0.52, alpha: 1).setStroke()
        rotated.lineWidth = 3
        rotated.stroke()
        let text = "\(Int(store.masterLevel * 100))"
        text.draw(at: NSPoint(x: cx - 28, y: 42), withAttributes: [.font: NSFont.monospacedDigitSystemFont(ofSize: 42, weight: .semibold), .foregroundColor: NSColor.labelColor])
        if store.isMIDILearnEnabled {
            "MIDI Learn".draw(at: NSPoint(x: 28, y: 284), withAttributes: [.font: NSFont.systemFont(ofSize: 12, weight: .semibold), .foregroundColor: NSColor.systemYellow])
        }
    }

    override func mouseDragged(with event: NSEvent) {
        store.masterLevel = min(max(store.masterLevel + Double(event.deltaY) / 180, 0), 1)
        needsDisplay = true
    }

    override func scrollWheel(with event: NSEvent) {
        store.masterLevel = min(max(store.masterLevel + Double(event.scrollingDeltaY) / 520, 0), 1)
        needsDisplay = true
    }
}

final class MeterBridgeView: NSStackView {
    private var bars: [NSProgressIndicator] = []

    init() {
        super.init(frame: .zero)
        orientation = .horizontal
        spacing = 12
        ["Main", "Cue", "Stream"].forEach { addArrangedSubview(makeMeter($0)) }
    }

    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func update(seed: Double, cut: Bool) {
        for (index, bar) in bars.enumerated() {
            bar.doubleValue = (cut ? 0.01 : seed * Double(index + 1) / 3.0) * 100
        }
    }

    private func makeMeter(_ name: String) -> NSView {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.spacing = 8
        stack.addArrangedSubview(Label(name, 12, .medium))
        for _ in 0..<2 {
            let bar = NSProgressIndicator()
            bar.minValue = 0
            bar.maxValue = 100
            bar.doubleValue = 40
            bar.isIndeterminate = false
            bars.append(bar)
            stack.addArrangedSubview(bar)
        }
        return stack.sized(width: 190)
    }
}

final class OutputCardView: NSView {
    init(output: MonitorOutput) {
        super.init(frame: .zero)
        wantsLayer = true
        layer?.cornerRadius = 10
        layer?.backgroundColor = NSColor.controlBackgroundColor.withAlphaComponent(0.72).cgColor
        let stack = VStack(in: self, inset: 12)
        stack.addArrangedSubview(Label(output.name, 14, .semibold))
        stack.addArrangedSubview(Label("\(output.role) - \(output.port)", 12, .regular, .secondaryLabelColor))
        let bar = NSProgressIndicator()
        bar.minValue = 0
        bar.maxValue = 100
        bar.doubleValue = output.level * 100
        bar.isIndeterminate = false
        stack.addArrangedSubview(bar)
        widthAnchor.constraint(equalToConstant: 210).isActive = true
        heightAnchor.constraint(equalToConstant: 104).isActive = true
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

@discardableResult
func VStack(in view: NSView, inset: CGFloat) -> NSStackView {
    let stack = NSStackView()
    stack.orientation = .vertical
    stack.alignment = .leading
    stack.spacing = 12
    stack.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(stack)
    NSLayoutConstraint.activate([
        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
        stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: inset),
        stack.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -inset)
    ])
    return stack
}

func Label(_ text: String, _ size: CGFloat, _ weight: NSFont.Weight = .regular, _ color: NSColor = .labelColor, _ wrapping: Bool = false) -> NSTextField {
    let field = NSTextField(labelWithString: text)
    field.font = NSFont.systemFont(ofSize: size, weight: weight)
    field.textColor = color
    field.maximumNumberOfLines = wrapping ? 0 : 1
    field.lineBreakMode = wrapping ? .byWordWrapping : .byTruncatingTail
    return field
}

extension NSView {
    func sized(width: CGFloat) -> NSView {
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
}
