#!/usr/bin/env python3

instructions = [
	("debug: off", "debug-off"),
	("debug: on", "debug-on"),
	("down", "down"),
	("down: NUMBER", "down-num"),
	("end-lines", "end-lines"),
	("end-lines-down", "end-lines-down"),
	("left", "left"),
	("left: Number", "left-num"),
	("paste: TEXT", "paste"),
	("paste-down: TEXT", "paste-down"),
	("paste-line: TEXT", "paste-line"),
	("paste-file: PATH", "paste-file"),
	("paste-file-lines: PATH", "paste-file-lines"),
	("paste-file-lines-down: PATH", "paste-file-lines-down"),
	("pause", "pause"),
	("pause: TIME", "pause-time"),
	("press: KEY", "press"),
	("press: MODIFIERS: KEY", "press-mod"),
	("repeat: KEY", "repeat"),
	("repeat: MODIFIERS: KEY", "repeat-mod"),
	("reset-delay", "reset-delay"),
	("return", "return"),
	("return: NUMBER", "return-num"),
	("right", "right"),
	("right: NUMBER", "right-num"),
	("set-delay: TIME", "set-delay-time"),
	("set-delay: MIN: MAX", "set-delay-min-max"),
	("space", "space"),
	("space: NUMBER", "space-num"),
	("start-lines", "start-lines"),
	("start-lines-down", "start-lines-down"),
	("stop", "stop"),
	("tab", "tab"),
	("tab: NUMBER", "tab-num"),
	("type: TEXT", "type"),
	("type-down: TEXT", "type-down"),
	("type-line: TEXT", "type-line"),
	("up", "up"),
	("up: NUMBER", "up-num"),
]

docs_path = "/Users/alan/Xcode-Projects/AutoTyper/AutoTyper/Docs"

for inst in instructions:
	print(f"#### {inst[0]}")
	print("")
	with open(f"{docs_path}/{inst[1]}.txt") as _in:
		lines = _in.read().splitlines()
		for line in lines:
			new_line = line.replace("###", "~")
			print(new_line)
		print("\n")
	print("---\n")
