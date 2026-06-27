# Banana Pointer

Banana Pointer is a planned native macOS studio monitor-control app. It is inspired by hardware monitor controllers and mixer-control software such as Audient Nero, Behringer X AIR, RME TotalMix, Focusrite Control, UA Console, and modern Mac utilities.

The signature control is a reflective gold-leaf banana used as the master monitor control. The actual product should still behave like serious studio software: source selection, speaker selection, cue mixes, dim, cut, mono, polarity, talkback, snapshots, meters, MIDI Learn, and dynamic output management.

## Current Status

This repo contains the research handoff plus a first native macOS scaffold.

- Read [CLAUDE_OPUS_4_8_HANDOFF.md](./CLAUDE_OPUS_4_8_HANDOFF.md) first.
- The current app is a lean AppKit scaffold with a demo control-room surface.
- It includes a banana master control, demo meters, outputs, snapshots, menu commands, MIDI Learn affordance, and a build/run script.

## Run

```sh
./script/build_and_run.sh
```

For a build and process check:

```sh
./script/build_and_run.sh --verify
```

The script stages a local `.app` bundle in `dist/` and launches it as a foreground macOS app. It currently compiles the AppKit scaffold directly with `xcrun swiftc`; the `Package.swift` remains as project metadata and a future SwiftPM path once the implementation settles.

## First Build Prompt

Read `CLAUDE_OPUS_4_8_HANDOFF.md` fully. Build the first PR-sized native macOS scaffold for Banana Pointer. Use SwiftUI, a demo audio service, a settings scene, commands, a menu bar extra if practical, MIDI service scaffolding, dynamic outputs model, and a main control-room layout. Include a high-quality fallback banana master control if no USDZ asset exists yet. Do not implement deep Core Audio routing or per-app audio in the first PR.
