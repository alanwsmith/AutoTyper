#!/usr/bin/env python3

lines = """A= 0x00
S= 0x01
D= 0x02
F= 0x03
H= 0x04
G= 0x05
Z= 0x06
X= 0x07
C= 0x08
V= 0x09
B= 0x0B
Q= 0x0C
W= 0x0D
E= 0x0E
R= 0x0F
Y= 0x10
T= 0x11
O= 0x1F
U= 0x20
I= 0x22
P= 0x23
L= 0x25
J= 0x26
K= 0x28
N= 0x2D
M= 0x2E"""

lns = []

for line in lines.split("\n"):
	parts = line.split("=")
	lns.append([parts[0].lower(), parts[1].strip()])
	
	#print(f"{parts[0].lower()}")

lns.sort(key=lambda x: x[0])

for ln in lns:
	print(f"\"{ln[0]}\": ({ln[1]}, nil),")
	print(f"\"{ln[0].upper()}\": ({ln[1]}, .maskShift),")




nums = """1= 0x12
2= 0x13
3= 0x14
4= 0x15
6= 0x16
5= 0x17
9= 0x19
7= 0x1A
8= 0x1C
0= 0x1D"""



holding = """
Equal                : CGKeyCode = 0x18
Minus                : CGKeyCode = 0x1B
RightBracket         : CGKeyCode = 0x1E
LeftBracket          : CGKeyCode = 0x21
Quote                : CGKeyCode = 0x27
Semicolon            : CGKeyCode = 0x29
Backslash            : CGKeyCode = 0x2A
Comma                : CGKeyCode = 0x2B
Slash                : CGKeyCode = 0x2C
Period               : CGKeyCode = 0x2F
Grave                : CGKeyCode = 0x32
KeypadDecimal        : CGKeyCode = 0x41
KeypadMultiply       : CGKeyCode = 0x43
KeypadPlus           : CGKeyCode = 0x45
KeypadClear          : CGKeyCode = 0x47
KeypadDivide         : CGKeyCode = 0x4B
KeypadEnter          : CGKeyCode = 0x4C
KeypadMinus          : CGKeyCode = 0x4E
KeypadEquals         : CGKeyCode = 0x51
Keypad0              : CGKeyCode = 0x52
Keypad1              : CGKeyCode = 0x53
Keypad2              : CGKeyCode = 0x54
Keypad3              : CGKeyCode = 0x55
Keypad4              : CGKeyCode = 0x56
Keypad5              : CGKeyCode = 0x57
Keypad6              : CGKeyCode = 0x58
Keypad7              : CGKeyCode = 0x59
Keypad8              : CGKeyCode = 0x5B
Keypad9              : CGKeyCode = 0x5C

// keycodes for keys that are independent of keyboard layout
kVK_Return= 0x24
kVK_Tab   = 0x30
kVK_Space = 0x31
kVK_Delete= 0x33
kVK_Escape= 0x35
kVK_Command                   : CGKeyCode = 0x37
kVK_Shift = 0x38
kVK_CapsLock                  : CGKeyCode = 0x39
kVK_Option= 0x3A
kVK_Control                   : CGKeyCode = 0x3B
kVK_RightCommand              : CGKeyCode = 0x36 // Out of order
kVK_RightShift                : CGKeyCode = 0x3C
kVK_RightOption               : CGKeyCode = 0x3D
kVK_RightControl              : CGKeyCode = 0x3E
kVK_Function                  : CGKeyCode = 0x3F
kVK_F17   = 0x40
kVK_VolumeUp                  : CGKeyCode = 0x48
kVK_VolumeDown                : CGKeyCode = 0x49
kVK_Mute  = 0x4A
kVK_F18   = 0x4F
kVK_F19   = 0x50
kVK_F20   = 0x5A
kVK_F5    = 0x60
kVK_F6    = 0x61
kVK_F7    = 0x62
kVK_F3    = 0x63
kVK_F8    = 0x64
kVK_F9    = 0x65
kVK_F11   = 0x67
kVK_F13   = 0x69
kVK_F16   = 0x6A
kVK_F14   = 0x6B
kVK_F10   = 0x6D
kVK_F12   = 0x6F
kVK_F15   = 0x71
kVK_Help  = 0x72
kVK_Home  = 0x73
kVK_PageUp= 0x74
kVK_ForwardDelete             : CGKeyCode = 0x75
kVK_F4    = 0x76
kVK_End   = 0x77
kVK_F2    = 0x78
kVK_PageDown                  : CGKeyCode = 0x79
kVK_F1    = 0x7A
kVK_LeftArrow                 : CGKeyCode = 0x7B
kVK_RightArrow                : CGKeyCode = 0x7C
kVK_DownArrow                 : CGKeyCode = 0x7D
kVK_UpArrow                   : CGKeyCode = 0x7E
"""