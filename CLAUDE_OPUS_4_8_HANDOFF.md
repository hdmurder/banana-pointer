# Banana Pointer - Claude Opus 4.8 Handoff

Research date: 2026-06-27  
Workspace: `/Users/kernel/Documents/Banana Pointer`  
Goal: Build a polished native macOS monitor-control app inspired by Audient Nero, Behringer/X AIR-style mix control, RME TotalMix, and modern creator utilities. The signature interaction is an exquisitely rendered rotating gold-leaf banana used as the master mix/monitor control.

## Executive Brief

Banana Pointer should feel like a serious studio monitor controller that happens to have one surreal, beautiful hero control. The product shape is:

**Nero simplicity + TotalMix power + SoundSource convenience + a gold-leaf banana master control.**

The first screen must be usable immediately: source select, speaker select, master volume, dim, cut/mute, mono, polarity, sub, talkback, meters, headphone/cue mixes, and monitor snapshots. The banana is the tactile master volume/control object, not a gimmick pasted onto a dashboard.

Build native. Use SwiftUI for app structure and macOS conventions. Use RealityKit for the 3D banana if targeting macOS 15+. Use a clear model/service boundary so the UI can run in demo mode before deeper Core Audio or virtual-device work exists.

## Source-Backed Market Findings

### Audient Nero

Reference: [Audient Nero overview](https://audient.com/products/monitor-controllers/nero/overview/), [Nero manual PDF](https://d9w4fhj63j193.cloudfront.net/2021/Nero/English/Audient%20Nero%20Manual%20V2%20EN.pdf), [Sweetwater Nero listing](https://www.sweetwater.com/store/detail/Nero--audient-nero-desktop-monitor-controller)

What matters:

- Hardware-first monitor controller, not a Mac app.
- Big tactile master volume.
- Multiple inputs, three speaker outputs, sub output, four headphone outputs.
- Talkback, dim, cut, mono, polarity.
- Smart Touchpoints for saved routing combinations.
- Speaker level matching and user-defined dim amount.

Implication for Banana Pointer:

- The main surface should feel like a control-room hub, not a general mixer.
- Critical monitor actions must be visible at all times.
- Saved routing/monitor states should be first-class.

### Behringer X AIR / X AIR Edit

Reference: [Behringer XR18 product page](https://www.behringer.com/en/products/0605-AAD), [X AIR App Store listing](https://apps.apple.com/us/app/x-air/id896725230)

What matters:

- Remote control for X18/XR18/XR16/XR12 mixers.
- Computer app support is described for PC, Mac, and Linux.
- Mirrored hardware control, multi-window editing, routing, effects, scenes, presets, and custom channel layout.
- App Store listing exposes the cautionary tale: stale reviews and compatibility pain hurt trust badly.

Implication:

- Include an offline/demo mode for setup without hardware.
- Have simple and advanced modes.
- Never leave network/device failure ambiguous. Show connection state, failure reason, and fallback.

### RME TotalMix FX / TotalMix Remote

Reference: [RME software page](https://rme-audio.de/software.html)

What matters:

- TotalMix Remote supports iOS, PC, and Mac control of TotalMix FX on a host system.
- RME is the power-user benchmark for routing, submixes, matrix views, snapshots, and workspaces.

Implication:

- Banana Pointer should not open on a wall of faders.
- Add an Expert Matrix view later for users who need TotalMix-like routing.
- MVP should expose "one output equals one monitor/cue mix" as the simple mental model.

### Focusrite Control 2

Reference: [Focusrite Control 2 desktop page](https://us.focusrite.com/software/focusrite-control-2), [Focusrite Control 2 App Store listing](https://apps.apple.com/sk/app/focusrite-control-2/id6479611881)

What matters:

- Focusrite describes Control 2 as a desktop app for macOS and Windows.
- App Store release history viewed on 2026-06-27 showed version 1.15.0 with Mix bus level/mute control and recent ISA C8X support.
- The UX tone is friendlier and less intimidating than RME.

Implication:

- Numeric readouts beside faders and knobs are required.
- A beginner-safe default layout is a feature, not a compromise.
- Keep hardware/version compatibility clear in Settings.

### Universal Audio Console

Reference: [UAD Console product page](https://www.uaudio.com/products/uad-console-app), [UAD Console overview](https://help.uaudio.com/hc/en-us/articles/25347160337556-UAD-Console-Overview)

What matters:

- Free companion app for Apollo/Volt hardware.
- Analog console metaphor with modern software workflow.
- Flex Routing, realtime plug-in monitoring, cue buses, talkback, monitor correction, bass management.
- UA support says the app controls low-latency hardware monitoring and that DSP work happens inside Apollo hardware, not host CPU.

Implication:

- Use "monitor/cue" language, not only "output volume."
- Talkback and cue mixes should feel central, not secondary.
- Avoid account/licensing heaviness for basic monitor control.

### MOTU / CueMix / AVB Control

Reference: [MOTU Pro Audio](https://motu.com/proaudio/index.html), [MOTU AVB Discovery App Store listing](https://apps.apple.com/us/app/motu-avb-discovery/id892558414)

What matters:

- Network discovery and hardware-hosted control panels are common in this category.
- The App Store discovery app gives one-touch access to a device control panel.

Implication:

- Device discovery needs a dedicated, honest state machine.
- Presets should be device/session-scoped.
- Keep the control surface usable even if the hardware-facing layer is still mocked.

### Apogee Control 2

Reference: [Apogee Control 2 App Store listing](https://apps.apple.com/us/app/apogee-control-2/id1588771047), [Apogee downloads](https://apogeedigital.com/download-files/)

What matters:

- Mobile and desktop control apps expose mic pre gain, speaker/headphone levels, mixer levels, metering, and sample rate.
- Apogee leans toward polished, device-specific studio control rather than a huge generic matrix.

Implication:

- The inspector should be output-first: select Speakers A, Headphones 1, Cue 2, then shape that mix.
- Meter preferences such as peak hold and clear peaks are worthwhile.

### Rogue Amoeba SoundSource / Loopback / Audio Hijack

Reference: [SoundSource](https://rogueamoeba.com/soundsource/), [Loopback](https://rogueamoeba.com/loopback/), [Audio Hijack](https://rogueamoeba.com/audiohijack/)

What matters:

- SoundSource is the Mac-native convenience benchmark: menu bar access, per-app volume, per-app output routing, effects, device groups, shortcuts.
- Loopback and Audio Hijack make routing visible as devices, wires, blocks, and sessions.

Implication:

- Banana Pointer should have a compact menu bar panel and global shortcuts eventually.
- Advanced routing can use a node/wire view later.
- Do not promise per-app routing in MVP unless the Core Audio tap or virtual-device layer is implemented and tested.

### Modern Mac Utility References

Reference: [Apple Design](https://developer.apple.com/design/), [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines), [Apple Liquid Glass announcement](https://www.apple.com/newsroom/2025/06/apple-introduces-a-delightful-and-elegant-new-software-design/), [Apple Design Resources](https://developer.apple.com/design/resources/), [Raycast](https://www.raycast.com/), [CleanShot X](https://cleanshot.com/), [Adobe Spectrum 2](https://adobe.design/ideas/introducing-spectrum-2)

What matters:

- Apple current direction is adaptive, layered, platform-native Liquid Glass.
- Adobe Spectrum 2 emphasizes feeling at home on each platform, accessibility, inclusivity, and joyful function.
- Raycast and CleanShot prove that premium utilities feel fast, keyboard-first, and low ceremony.

Implication:

- Use native macOS chrome, keyboard commands, focus behavior, menus, toolbars, inspectors, and settings.
- Use glass/materials as functional hierarchy, not an all-over theme.
- The UI should say "studio tool," not "2008 VST plugin."

## Product Definition

### Target User

- Mac-based musicians, producers, podcasters, editors, streamers, and small studio owners.
- People who want a monitor-controller brain without opening a DAW.
- People who use audio interfaces, headphones, speakers, virtual devices, and app audio in shifting combinations.

### Product Promise

"A beautiful Mac-native control room for your studio audio, centered around a tactile gold-leaf banana master control."

### Non-Goals For MVP

- Do not build a DAW.
- Do not build a full replacement for TotalMix on day one.
- Do not build a kernel/system extension first.
- Do not claim universal per-app routing unless the implementation genuinely supports it.
- Do not make skeuomorphic fake hardware panels, screws, brushed metal, leather, or giant glossy VST-style controls.

## MVP Scope

### Must Have

- Native macOS app shell in SwiftUI.
- Main window with control-room layout.
- 3D or high-quality fallback banana master control.
- Demo audio-control model with realistic devices, sources, outputs, cue mixes, and meters.
- Device/source selector.
- Speaker output selector: Main, Alt 1, Alt 2, Sub.
- Main monitor actions: Dim, Cut/Mute, Mono, Polarity, Talkback.
- Headphone/cue mix cards.
- Saved monitor states/snapshots.
- Meter bridge with peak hold.
- Inspector for selected output/mix.
- Settings window.
- Keyboard shortcuts for critical actions.
- Accessibility for the banana control as an adjustable slider-like control.
- Reduced Motion and Reduce Transparency handling.

### Should Have

- Menu bar extra with master level, mute, output selection, and open main window.
- Local persistence for snapshots and preferences.
- Simulated device failure/offline states.
- First Core Audio adapter for enumerating default input/output devices and reading or setting available device volume where public APIs allow.

### Later

- Expert routing matrix.
- Node/wire signal-flow view.
- Audio Unit effect hosting.
- Per-app audio control, if feasible with supported public APIs and appropriate permissions.
- Hardware integration adapters.
- Network remote companion.

## Recommended Architecture

Use a clean separation between the UI and audio implementation from the first commit.

```text
BananaPointer/
  App/
    BananaPointerApp.swift
    AppCommands.swift
  Models/
    AudioDevice.swift
    MonitorOutput.swift
    MixChannel.swift
    CueMix.swift
    Snapshot.swift
    MeterLevel.swift
  Stores/
    AppStore.swift
    SnapshotStore.swift
    PreferencesStore.swift
  Services/
    AudioControlService.swift
    DemoAudioControlService.swift
    CoreAudioDeviceService.swift
  Views/
    ContentView.swift
    SidebarView.swift
    ControlRoomView.swift
    BananaMasterControl.swift
    MeterBridgeView.swift
    ChannelStripView.swift
    CueMixView.swift
    RoutingMatrixView.swift
    InspectorView.swift
    SettingsView.swift
    MenuBarControlView.swift
  Assets/
    BananaMaster.usdz
    BananaGoldLeafEnvironment.exr
  Support/
    Formatters.swift
    AccessibilityLabels.swift
    HapticsOrFeedback.swift
```

### State Ownership

- `AppStore`: app-wide observable state.
- `AudioControlService`: protocol boundary for demo, Core Audio, or future hardware adapters.
- `@SceneStorage`: selected sidebar item, selected output, visible inspector tab.
- `@AppStorage`: UI density, reduced animation preference mirror, meter peak hold, dim amount.
- Snapshots persisted as JSON in Application Support for v1.

### Service Contract

```swift
protocol AudioControlService {
    var devices: [AudioDevice] { get async }
    var outputs: [MonitorOutput] { get async }
    var channels: [MixChannel] { get async }
    var meters: AsyncStream<[MeterLevel]> { get }

    func setMasterLevel(_ value: Double) async throws
    func setOutputLevel(_ outputID: MonitorOutput.ID, value: Double) async throws
    func setMute(_ isMuted: Bool) async throws
    func setDim(_ isDimmed: Bool) async throws
    func setMono(_ isMono: Bool) async throws
    func setPolarityInverted(_ isInverted: Bool) async throws
    func setTalkback(_ isActive: Bool) async throws
    func recallSnapshot(_ snapshot: Snapshot) async throws
}
```

Demo mode should implement the full contract. CoreAudio v1 can implement only the subset that is safely supported and should clearly mark unsupported controls as simulated or unavailable.

## Visual Direction

### Overall Feel

Modern Apple hardware translated into a studio tool:

- Graphite, smoked glass, blackened metal, soft off-white labels.
- Signal colors only where meaningful: green level, amber warning, red clip/mute, blue selection, gold hero control.
- Compact pro density, not a landing page.
- Native sidebars and toolbars where they help.
- Inspector panels for details.
- No cards inside cards.
- No fake hardware screws or novelty skeuomorphism.

### Main Window Layout

Use a `NavigationSplitView` or deliberate three-zone desktop layout:

- Left: source/output/snapshot sidebar.
- Center: control room.
- Right: inspector for selected output, cue mix, or routing lane.
- Top toolbar: device status, search if useful, snapshot recall, settings, compact/menu toggle.

Center control-room layout:

```text
┌────────────────────────────────────────────────────────────────┐
│ Toolbar: device, snapshot, transport-like status, settings      │
├───────────────┬──────────────────────────────────┬─────────────┤
│ Sources       │ Meter bridge                     │ Inspector   │
│ Outputs       │                                  │             │
│ Snapshots     │        Gold Banana Control        │ Selected    │
│               │                                  │ output/mix  │
│               │ Dim Cut Mono Polarity Sub Talkback│ details     │
│               │                                  │             │
│               │ Cue Mixes / Channel Strips        │             │
└───────────────┴──────────────────────────────────┴─────────────┘
```

### Banana Master Control

The banana is the signature control.

Behavior:

- Drag vertically or rotate with pointer to change master level.
- Scroll wheel/trackpad adjusts in fine increments.
- Option-drag for fine control.
- Double-click resets to calibrated reference level.
- Keyboard arrows adjust.
- Shift or Option changes step size.
- VoiceOver exposes label "Master monitor level", value in dB/percent, adjustable actions.
- Reduced Motion disables continuous spin and uses subtle highlight shifts instead.

Visual:

- Gold-leaf material with fine wrinkles, flakes, and irregular reflectance.
- The banana rotates just enough to reveal reflected light movement.
- Use environment lighting/reflection maps, not random glitter.
- It should feel like a luxury object under studio lights, not a cartoon banana.

Technical recommendation:

- Prefer RealityKit `RealityView` on macOS 15+.
- Author the asset in Blender and export USDZ/USDC.
- Use PBR material: gold base, high metallic, controlled roughness, normal map for leaf texture.
- Use a pseudo-3D SwiftUI fallback if RealityKit is unavailable or if accessibility/reduced-power mode is active.
- Avoid raw Metal until PBR proves insufficient.
- Avoid WKWebView/Three.js for production unless a web prototype must be reused.

Apple references:

- [RealityKit](https://developer.apple.com/documentation/realitykit)
- [RealityView](https://developer.apple.com/documentation/realitykit/realityview)
- [Bring your SceneKit project to RealityKit - WWDC25](https://developer.apple.com/videos/play/wwdc2025/288/)
- [PhysicallyBasedMaterial](https://developer.apple.com/documentation/RealityKit/PhysicallyBasedMaterial)
- [SwiftUI accessibility adjustable actions](https://developer.apple.com/documentation/swiftui/view/accessibilityadjustableaction%28_%3A%29)

## Audio Implementation Notes

This is the main risk area. Treat it honestly.

### Safe MVP Approach

1. Build the full product UI and state model against `DemoAudioControlService`.
2. Add `CoreAudioDeviceService` for:
   - enumerating input/output devices,
   - reading the default output where supported,
   - setting system/default device volume only where public APIs allow,
   - watching device changes.
3. Keep routing, cue buses, per-app controls, and effects simulated until real implementations are proven.

### Why

- System-wide and per-app audio control on macOS is not a simple public "set app volume" API.
- SoundSource/Loopback class features often imply deeper Core Audio taps, virtual devices, helper tools, permissions, or driver-like components.
- A beautiful working control surface with honest capability states is better than a fragile app that claims too much.

References:

- [Core Audio](https://developer.apple.com/documentation/coreaudio)
- [AVAudioEngine](https://developer.apple.com/documentation/avfaudio/avaudioengine)
- [Capturing system audio with Core Audio taps](https://developer.apple.com/documentation/coreaudio/capturing-system-audio-with-core-audio-taps)
- [Audio Unit v3 plug-ins](https://developer.apple.com/documentation/audiotoolbox/audio-unit-v3-plug-ins)
- [Apple Aggregate Device support article](https://support.apple.com/en-us/102171)

## MIDI Controller And MIDI Learn Pass

Banana Pointer should support dedicated MIDI controller operation. The target behavior is DAW-like MIDI Learn: enter learn mode, click a Banana Pointer control, move a hardware fader/knob/pad, confirm the mapping, and then use the hardware globally while the app is running.

### Product Requirements

- Add `MIDI Learn` mode with `Command+L`.
- Highlight assignable controls while MIDI Learn is active.
- Let the user click an app control, then move or press one MIDI hardware control.
- Capture device, channel, message type, controller/note number, and value range.
- Show the captured mapping before saving.
- Let users invert, scale, set min/max, set pickup mode, and choose toggle/momentary behavior.
- Persist mappings per controller using Core MIDI unique ID plus fallback device name/manufacturer/model.
- Support multiple maps: `Studio`, `Tracking`, `Streaming`, `Live`, and `Custom`.
- Add a `MIDI` tab in Settings with devices, mappings, conflicts, and controller profiles.
- Add a foreground-only safety toggle: `Ignore MIDI unless Banana Pointer is active`.

### Technical Recommendation

Implement `MIDIControllerService` with Core MIDI:

```swift
protocol MIDIControllerService {
    var sources: [MIDISource] { get async }
    var destinations: [MIDIDestination] { get async }
    var events: AsyncStream<MIDIEvent> { get }

    func connect(sourceID: MIDISource.ID) async throws
    func disconnect(sourceID: MIDISource.ID) async throws
    func sendFeedback(_ message: MIDIMessage, to destinationID: MIDIDestination.ID) async throws
}
```

Normalize incoming MIDI 1.0 messages first:

- Continuous faders/knobs: Control Change, 0-127.
- Pads/buttons: Note On/Off, including Note On velocity 0 as release.
- Optional: Pitch bend for continuous master or crossfade style controls.
- Later: MIDI 2.0 higher-resolution controls where supported.

References:

- [Core MIDI](https://developer.apple.com/documentation/coremidi/)
- [MIDI Services](https://developer.apple.com/documentation/coremidi/midi-services)
- [Incorporating MIDI 2 into your apps](https://developer.apple.com/documentation/coremidi/incorporating-midi-2-into-your-apps)
- [Audio MIDI Setup - set up MIDI devices](https://support.apple.com/guide/audio-midi-setup/set-up-midi-devices-ams875bae1e0/mac)
- [Audio MIDI Setup - transfer MIDI between apps with IAC Driver](https://support.apple.com/guide/audio-midi-setup/transfer-midi-information-between-apps-ams1013/mac)
- [Audio MIDI Setup - Bluetooth MIDI](https://support.apple.com/guide/audio-midi-setup/set-up-bluetooth-midi-devices-ams33f013765/mac)
- [Ableton Live MIDI and Key Remote Control](https://www.ableton.com/en/manual/midi-and-key-remote-control/)

### DAW Interaction And Conflict Rules

MIDI should be treated as process-level input, not keyboard focus. Banana Pointer can listen while backgrounded. The bigger issue is not usually exclusive access on macOS, but duplicate behavior: a DAW may respond to the same controller if MIDI Remote or a control-surface script is enabled.

Rules:

- Default to `Dedicated Banana Controller` mode for the safest workflow.
- Warn when a learned controller looks like a known DAW control surface profile.
- Add `Shared with DAW` mode with channel filtering.
- Recommend users put Banana Pointer mappings on a dedicated MIDI channel, user mode, or custom mode.
- Provide a help note for IAC Driver when a user wants routing between apps.
- For LED feedback, only enable output messages for known profiles or explicit user opt-in.

### First Controller Profiles

Start generic, then add profiles:

- Generic CC faders/knobs/buttons.
- Akai APC Mini style pad grid/faders. Useful for button LED feedback later.
- Korg nanoKONTROL2 style 8-channel strip.
- Novation Launch Control XL 3 style faders/encoders/custom modes.
- Nektar Impact/LX style keyboard controller with faders/knobs/pads.
- M-VAVE/SMC-Mixer style low-cost fader controller, input-only at first.

## Controller Sourcing Notes

The app should work with standard class-compliant MIDI controllers rather than requiring one branded device. Still, a recommended "Banana Pointer controller" list will help users and collaborators.

### Safer Branded Recommendations

- [Novation Launch Control XL 3](https://us.novationmusic.com/products/launch-control-xl): strong best-fit for a dedicated Banana Pointer controller. It has eight faders, 24 endless encoders, 16 assignable buttons, USB/MIDI I/O, OLED feedback, and custom modes.
- [Korg nanoKONTROL2](https://www.korg.com/us/products/computergear/nanokontrol2/): cheap, compact, familiar 8-channel layout with knob, fader, and three switches per channel.
- [Nektar controllers](https://nektartech.com/products/): useful when the user also wants keys. The Impact/LX line has DAW integration, mixer controls, knobs, pads, and transport controls.
- Akai APC Mini/APC Mini mk2: good for pad-grid plus fader workflows, especially if Banana Pointer later supports LED feedback profiles.

### Off-Market / Alibaba-Style Candidates

Use these for testing and sourcing exploration, not as the default recommendation until physically verified:

- M-VAVE SMC-Mixer / similar wireless MIDI mixer controllers: Alibaba listings exist, and the Mixxx hardware page confirms the controller can connect over Bluetooth, USB-C, or both. For Banana Pointer, recommend USB-C first for reliability.
- Worlde Panda / Panda Mini style controllers: Alibaba pages show low-cost ready-to-ship devices and customization options. These are useful for cheap test coverage, but build quality, editor software, and firmware consistency must be verified.
- M-VAVE Chocolate style foot controllers: useful for talkback, mute, dim, or snapshot recall via footswitch, not for fader-heavy workflows.
- Generic "USB MIDI controller with 8 faders / 8 knobs / pads" listings: only consider if they are class compliant, USB-C, programmable CC/Note output, and available in small quantities before any logo/custom order.

Sourcing caveats:

- Prefer wired USB-C over Bluetooth for studio control.
- Avoid controllers requiring proprietary dongles.
- Confirm they appear in macOS Audio MIDI Setup.
- Confirm every fader sends stable absolute CC data.
- Confirm buttons can send Note or CC messages with clear press/release behavior.
- Do not depend on LED feedback unless the protocol is documented.
- Alibaba MOQs and customization claims vary; buy 1-2 samples before considering any public recommendation.

Useful references:

- [Alibaba Bluetooth MIDI controller buying guide](https://electronics.alibaba.com/buyingguides/bluetooth-midi-controller-guide-what-actually-matters-in-2026)
- [Alibaba Worlde 25-key MIDI product intro](https://www.alibaba.com/product-introduction/Worlde-brand-midi-keyboard-piano-25_1600378729586.html)
- [M-VAVE SMC-Mixer in Mixxx manual](https://manual.mixxx.org/2.7/en/hardware/controllers/mvave_smc_mixer)
- [Worlde Panda Mini II manual PDF](https://www.worlde.com.cn/static/upload/file/20210318/1616047084931337.pdf)

## Dynamic Outputs And Routing UX

The UI must allow users to add outputs as needed without flooding the screen with unused ports. This should feel closer to DAWs adding tracks/buses/auxes on demand than to a fixed hardware panel.

### Core Mental Model

Separate capacity from visibility:

- Capacity: all available hardware ports, virtual outputs, cue mixes, buses, and future app returns.
- Visibility: only pinned, active, recently edited, clipping, or snapshot-referenced outputs appear on the main surface.

### Output Types

`+ Output` should open a compact sheet with:

- Speaker Set
- Headphones
- Cue Mix
- Bus/Submix
- Stream Mix
- Print Bus
- Virtual/App Return
- External Hardware Send

Each output gets:

- Name
- Role
- Icon
- Color
- Channel format: mono, stereo, multichannel
- Hardware port assignment
- Pin to main surface toggle
- Talkback receive toggle
- Snapshot membership

### Outputs Drawer

Add an `Outputs` drawer or inspector with sections:

- Pinned
- Active Signal
- Available
- Hidden
- Offline
- Conflicts

Visibility rules:

- Hide unused outputs by default.
- Never delete automatically.
- Auto-surface outputs that receive signal, clip, are referenced by a snapshot, or have a hardware conflict.
- Provide `Show Hidden Outputs` and `Show All Hardware Ports` commands.

### Cue Mix Pattern

Each output can own its own mix. Main surface should show cue cards with:

- output name,
- level,
- mute,
- selected source,
- mini meter,
- talkback receive status,
- `Edit Mix`.

`Edit Mix` opens a focused view for that output. Do not dump every channel into the main screen.

### Save Types

Separate:

- Snapshot: monitor state, cue levels, mutes, routing.
- Layout: visible/pinned/hidden UI arrangement.
- Workspace: device + layout + snapshots bundle.

This prevents recalling a monitor mix from unexpectedly rearranging the UI.

### Expert Mode

Use a segmented control:

`Control Room | Cues | Matrix`

- Control Room: calm default.
- Cues: output-by-output mix editing.
- Matrix: dense routing for power users.

### Conflict Handling

When outputs collide:

- Show inline badge: `Port 3-4 already used by Cue 1`.
- Offer `Share`, `Replace`, or `Disable Other Output`.
- Keep raw hardware labels secondary to user labels: `Performer Mix`, then `Output 7-8`.

## Interaction Requirements

### Keyboard

- Space: toggle Cut/Mute when focused in control room.
- D: Dim.
- M: Mono.
- P: Polarity.
- T: Talkback momentary while held, toggle if clicked.
- Up/Down: master level.
- Option + Up/Down: fine level.
- Command + 1/2/3: speaker outputs.
- Command + Shift + number: recall snapshot.
- Command + L: MIDI Learn.

### Menus

Add native commands:

- File: New Snapshot, Import/Export Snapshots.
- Control: Dim, Cut, Mono, Polarity, Talkback, Select Output.
- View: Show Inspector, Show Routing Matrix, Compact Mode, Meter Peak Hold.
- Window: standard macOS window handling.
- Help: Banana Pointer Help, Audio Permissions.

### Settings

Settings should be a real `Settings` scene, not a route inside the main window.

Tabs:

- Audio: device selection, calibration, default output behavior.
- Control Room: dim amount, reference level, speaker trims.
- Appearance: density, meter style, banana quality, reduced motion.
- Shortcuts: keyboard shortcuts.
- Advanced: demo mode, logs, experimental Core Audio features.

## Build Plan For Claude

### Phase 0 - Scaffold

Acceptance:

- Native macOS app opens as a foreground `.app`.
- Folder structure matches the handoff.
- Main window, Settings scene, commands, and menu bar extra exist.
- Demo state loads with plausible devices and meters.

Implementation:

- Use SwiftUI lifecycle.
- `WindowGroup` for main window.
- `Settings` for preferences.
- `MenuBarExtra` if it does not complicate launch behavior. If main window must appear at launch, use an app delegate to keep regular activation policy.

### Phase 1 - Product Surface

Acceptance:

- User can interact with all core monitor controls in demo mode.
- Meters animate.
- Snapshots can be created, recalled, renamed, and deleted.
- Inspector reflects selected output/cue mix.
- Keyboard shortcuts work.

Implementation:

- Build `ControlRoomView`, `MeterBridgeView`, `ChannelStripView`, `CueMixView`, `InspectorView`.
- Keep controls compact and deterministic.
- Persist snapshots locally.

### Phase 2 - Banana Control

Acceptance:

- Banana control changes master level.
- Drag, scroll, keyboard, and VoiceOver actions all update the same state.
- Reduced Motion and fallback rendering work.
- If RealityKit asset is unavailable, app still builds and shows an elegant fallback.

Implementation:

- Start with a placeholder primitive or generated simple banana mesh.
- Replace with `BananaMaster.usdz` when asset exists.
- Keep material settings isolated so design iteration is easy.

### Phase 3 - Core Audio Adapter

Acceptance:

- App lists real audio devices.
- App can show the current default output.
- Supported system/device volume control works.
- Unsupported controls are visibly unavailable or simulated, not silently fake.

Implementation:

- Add `CoreAudioDeviceService`.
- Keep demo mode switch.
- Log capability reasons in a debug inspector.

### Phase 4 - Polish And Verification

Acceptance:

- Light and Dark modes are good.
- Text never overlaps at compact and large sizes.
- Keyboard-only flow works.
- VoiceOver can operate the master control.
- App remains responsive with animated meters.
- Build succeeds from the repo script.

Implementation:

- Add build script and Codex environment file if starting from scratch.
- Use Instruments or Xcode gauges for RealityKit rendering if the banana is active.

## Design Guardrails

Do:

- Use native macOS structure first.
- Let sidebars/toolbars use system materials.
- Use Liquid Glass for functional grouping, not every surface.
- Keep dense controls rounded-rectangle, not oversized capsules.
- Use SF Symbols for toolbar and button icons.
- Use numeric readouts for all critical audio values.
- Use clear empty/offline/error states.
- Keep the banana luxurious and restrained.

Do not:

- Open with a marketing hero page.
- Hide Dim/Cut/Mono/Talkback in menus only.
- Build a single giant `ContentView`.
- Use fixed white backgrounds.
- Make everything purple, blue-gradient, beige, or one-note dark slate.
- Use fake screws, leather, old brushed metal, or Aqua-style bevels.
- Make the banana control inaccessible.
- Claim per-app routing before it is real.

## Acceptance Criteria For First PR

- The repo contains a native macOS app scaffold.
- Running the app opens a main Banana Pointer window.
- Main window has the control-room layout with demo devices.
- Master banana/fallback control updates master level.
- Dim, Cut, Mono, Polarity, Sub, Talkback controls update state.
- Meter bridge animates from demo data.
- Settings window exists.
- At least five snapshots can be created/recalled.
- Keyboard shortcuts for Dim, Cut, Mono, and master level work.
- Build instructions are documented in `README.md`.
- No broad implementation of real per-app audio is attempted in PR 1.

## Suggested First Prompt For Claude Opus 4.8

Read `CLAUDE_OPUS_4_8_HANDOFF.md` fully. Build the first PR-sized native macOS scaffold for Banana Pointer in this workspace. Follow the architecture and Phase 0/Phase 1 acceptance criteria. Use SwiftUI, a demo audio service, a settings scene, commands, and a main control-room layout. Include a high-quality fallback banana master control if no USDZ asset exists yet. Do not implement deep Core Audio routing or per-app audio in this PR. Keep the app buildable and document how to run it.

## Research Credits

Parallel agents contributed:

- Market scan across audio-control products and adjacent Mac audio utilities.
- Visual design scan across modern macOS utility apps, Adobe/Spectrum patterns, App Store examples, and Pinterest-era trend signals.
- Technical feasibility scan for RealityKit, Blender/USDZ assets, PBR gold-leaf material, accessibility, and performance.
