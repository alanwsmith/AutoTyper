#!/usr/bin/env python3

data = """A= 0x00
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
M= 0x2E
1= 0x12
2= 0x13
3= 0x14
4= 0x15
6= 0x16
5= 0x17
9= 0x19
7= 0x1A
8= 0x1C
0= 0x1D
Keypad-Decimal        = 0x41
Keypad-Multiply       = 0x43
Keypad-Plus           = 0x45
Keypad-Clear          = 0x47
Keypad-Divide         = 0x4B
Keypad-Enter          = 0x4C
Keypad-Minus          = 0x4E
Keypad-Equals         = 0x51
Keypad-0              = 0x52
Keypad-1              = 0x53
Keypad-2              = 0x54
Keypad-3              = 0x55
Keypad-4              = 0x56
Keypad-5              = 0x57
Keypad-6              = 0x58
Keypad-7              = 0x59
Keypad-8              = 0x5B
Keypad-9              = 0x5C
Return                    = 0x24
Tab                       = 0x30
Space                     = 0x31
Delete                    = 0x33
Escape                    = 0x35
Command                   = 0x37
Shift                     = 0x38
Caps-Lock                  = 0x39
Option                    = 0x3A
Control                   = 0x3B
Function                  = 0x3F
F17                       = 0x40
Volume-Up                  = 0x48
Volume-Down                = 0x49
Mute                      = 0x4A
F18                       = 0x4F
F19                       = 0x50
F20                       = 0x5A
F5                        = 0x60
F6                        = 0x61
F7                        = 0x62
F3                        = 0x63
F8                        = 0x64
F9                        = 0x65
F11                       = 0x67
F13                       = 0x69
F16                       = 0x6A
F14                       = 0x6B
F10                       = 0x6D
F12                       = 0x6F
F15                       = 0x71
Help                      = 0x72
Home                      = 0x73
Page-Up                    = 0x74
Forward-Delete             = 0x75
F4                        = 0x76
End                       = 0x77
F2                        = 0x78
Page-Down                  = 0x79
F1                        = 0x7A
Left-Arrow                 = 0x7B
Right-Arrow                = 0x7C
Down-Arrow                 = 0x7D
Up-Arrow                   = 0x7E
ISO-Section               = 0x0A
JIS-Yen                   = 0x5D
JIS-Underscore            = 0x5E
Keypad-JIS-Comma           = 0x5F
JIS-Eisu                  = 0x66
JIS_Kana                  = 0x68
- = 0x1B
[ = 0x1E
] = 0x21
' = 0x27
; = 0x29
\\\\ = 0x2A
, = 0x2B
/ = 0x2C
. = 0x2F
~ = 0x32"""

items = {}

lines = data.split("\n")
for line in lines:
	parts = line.split("=")
	items[parts[0].strip().lower()] = parts[1].strip()

# Start with ``=`` since it's used as the separator and
# therefor not in the list
	
#print(f"if parts[1] == \"=\" " + "{ " + f"codesToType.append(0x18) " + "}") 
print(f"\"=\": (0x18, \"\"),") 
print(f"\"enter\": (0x24, \"\"),")
	
# Then print everything else at as ``else if`` statments
for key in sorted(items):
	#	print(f"else if parts[1] == \"{key}\" " + "{ " + f"codesToType.append({items[key]}) " + "}") 
	print(f"\"{key}\": ({items[key]}, \"\"),") 

	