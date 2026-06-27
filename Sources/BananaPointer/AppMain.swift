import AppKit

@main
final class BananaPointerApp: NSObject, NSApplicationDelegate {
    private var window: NSWindow?
    private let store = StudioStore()

    static func main() {
        let app = NSApplication.shared
        let delegate = BananaPointerApp()
        app.delegate = delegate
        app.setActivationPolicy(.regular)
        app.run()
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.mainMenu = AppMenu.make(delegate: self)
        showWindow()
        store.startMeters()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        false
    }

    @objc func showWindow() {
        if window == nil {
            let controller = StudioViewController(store: store)
            let nextWindow = NSWindow(contentViewController: controller)
            nextWindow.title = "Banana Pointer"
            nextWindow.setContentSize(NSSize(width: 1120, height: 720))
            nextWindow.minSize = NSSize(width: 960, height: 620)
            nextWindow.styleMask = [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView]
            nextWindow.titlebarAppearsTransparent = true
            nextWindow.toolbarStyle = .unified
            nextWindow.center()
            window = nextWindow
        }
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    @objc func toggleDim() { store.isDimmed.toggle() }
    @objc func toggleCut() { store.isCut.toggle() }
    @objc func toggleMono() { store.isMono.toggle() }
    @objc func toggleMIDILearn() { store.isMIDILearnEnabled.toggle() }
    @objc func addCueOutput() { store.addCueOutput() }
    @objc func newSnapshot() { store.createSnapshot() }

    @objc func showSettings() {
        let alert = NSAlert()
        alert.messageText = "Banana Pointer Settings"
        alert.informativeText = "Demo mode is active. Core Audio and Core MIDI adapters are next."
        alert.runModal()
    }
}

enum AppMenu {
    static func make(delegate: BananaPointerApp) -> NSMenu {
        let main = NSMenu()
        let appItem = NSMenuItem()
        main.addItem(appItem)

        let app = NSMenu()
        app.addItem(withTitle: "Settings...", action: #selector(BananaPointerApp.showSettings), keyEquivalent: ",")
        app.addItem(.separator())
        app.addItem(withTitle: "Quit Banana Pointer", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        appItem.submenu = app

        let controlItem = NSMenuItem()
        main.addItem(controlItem)
        let controls = NSMenu(title: "Control Room")
        controls.addItem(withTitle: "Toggle Dim", action: #selector(BananaPointerApp.toggleDim), keyEquivalent: "d")
        controls.addItem(withTitle: "Toggle Cut", action: #selector(BananaPointerApp.toggleCut), keyEquivalent: " ")
        controls.addItem(withTitle: "Toggle Mono", action: #selector(BananaPointerApp.toggleMono), keyEquivalent: "m")
        let learn = controls.addItem(withTitle: "MIDI Learn", action: #selector(BananaPointerApp.toggleMIDILearn), keyEquivalent: "l")
        learn.keyEquivalentModifierMask = [.command]
        controls.addItem(.separator())
        let cue = controls.addItem(withTitle: "Add Cue Output", action: #selector(BananaPointerApp.addCueOutput), keyEquivalent: "o")
        cue.keyEquivalentModifierMask = [.command, .shift]
        controls.addItem(withTitle: "New Snapshot", action: #selector(BananaPointerApp.newSnapshot), keyEquivalent: "s")
        controlItem.submenu = controls
        return main
    }
}
