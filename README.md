# Banana Pointer

Banana Pointer is a planned native macOS studio monitor-control app. It is inspired by hardware monitor controllers and mixer-control software such as Audient Nero, Behringer X AIR, RME TotalMix, Focusrite Control, UA Console, and modern Mac utilities.

The signature control is a reflective gold-leaf banana used as the master monitor control. The actual product should still behave like serious studio software: source selection, speaker selection, cue mixes, dim, cut, mono, polarity, talkback, snapshots, meters, MIDI Learn, and dynamic output management.

## Current Status

This repo currently contains the research and implementation handoff for agents.

- Read [CLAUDE_OPUS_4_8_HANDOFF.md](./CLAUDE_OPUS_4_8_HANDOFF.md) first.
- The app has not been scaffolded yet.
- First implementation target: native SwiftUI macOS app with demo audio service and a buildable control-room UI.

## First Build Prompt

Read `CLAUDE_OPUS_4_8_HANDOFF.md` fully. Build the first PR-sized native macOS scaffold for Banana Pointer. Use SwiftUI, a demo audio service, a settings scene, commands, a menu bar extra if practical, MIDI service scaffolding, dynamic outputs model, and a main control-room layout. Include a high-quality fallback banana master control if no USDZ asset exists yet. Do not implement deep Core Audio routing or per-app audio in the first PR.

