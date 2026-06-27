import AppKit

struct MonitorOutput {
    var name: String
    var role: String
    var level: Double
    var port: String
}

struct Snapshot {
    var name: String
    var master: Double
}

final class StudioStore: NSObject {
    @objc dynamic var masterLevel = 0.72
    @objc dynamic var isDimmed = false
    @objc dynamic var isCut = false
    @objc dynamic var isMono = false
    @objc dynamic var isMIDILearnEnabled = false
    @objc dynamic var meterSeed = 0.42

    var outputs = [
        MonitorOutput(name: "Main Speakers", role: "Speakers", level: 0.72, port: "Output 1-2"),
        MonitorOutput(name: "Alt Nearfields", role: "Speakers", level: 0.64, port: "Output 3-4"),
        MonitorOutput(name: "Performer Cue", role: "Cue Mix", level: 0.58, port: "Output 5-6"),
        MonitorOutput(name: "Stream Mix", role: "Stream", level: 0.51, port: "Virtual 1-2")
    ]

    var snapshots = [
        Snapshot(name: "Mix Check", master: 0.72),
        Snapshot(name: "Tracking", master: 0.55),
        Snapshot(name: "Late Night", master: 0.31)
    ]

    private var timer: Timer?

    func startMeters() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.16, repeats: true) { [weak self] _ in
            self?.meterSeed = Double.random(in: 0.08...0.94)
        }
    }

    func addCueOutput() {
        let count = outputs.filter { $0.role == "Cue Mix" }.count + 1
        outputs.append(MonitorOutput(name: "Cue Mix \(count)", role: "Cue Mix", level: 0.5, port: "Unassigned"))
        NotificationCenter.default.post(name: .studioStoreChanged, object: self)
    }

    func createSnapshot() {
        snapshots.insert(Snapshot(name: "Snapshot \(snapshots.count + 1)", master: masterLevel), at: 0)
        NotificationCenter.default.post(name: .studioStoreChanged, object: self)
    }
}

extension Notification.Name {
    static let studioStoreChanged = Notification.Name("BananaPointerStudioStoreChanged")
}
