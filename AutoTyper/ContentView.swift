//
//  ContentView.swift
//  AutoTyper
//
//  Created by Alan W. Smith on 11/21/24.
//

import SwiftUI

// TODO: Handle unknow characters

struct ErrorPayload {
    let line: String
    let message: String
}

struct PotentialApp: Identifiable, Hashable {
    let app: NSRunningApplication
    let id: pid_t
}

struct SyntaxItem: Identifiable, Hashable {
    let headline: String
    let paragraphs: [String]
    let id = UUID()
}

struct StatusView: View{
    var statusLine: String = "Status"
    var statusArea: String = "Status area"
    var body: some View {
        VStack{
            Text(statusLine).frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            ScrollView {
                Text(statusArea).frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }.padding()
    }
}

struct DocsView: View{
    let syntaxItems: [SyntaxItem] = [
        SyntaxItem(headline: "debug|on", paragraphs: ["Remove all delays and pauses to fast-forward until `debug|off` or the end of the script"]),
        
        SyntaxItem(headline: "debug|off", paragraphs: ["Restores all pauses so script runs at specified delays and pauses"]),
        
        SyntaxItem(headline: "hold|MODIFIERS|KEY", paragraphs: [
            "Holds down the MODIFIER (or MODIFIERS) and presses the KEY",
            "Examples:",
            "- hold|command|a\n- hold|command|f5\n- hold|command,shift|r",
            "The possible MODIFIER options are:",
            "- command\n- control\n- option\n- shift",
            "Separate multiple MODIFIERS with commas",
            "The KEY can be lower case letters, numbers, and punctuation that doesn't require pressing shift, or key with functionality (e.g. `escape`, `return`, `up-arrow`, `f1`, `f2`, etc..)",
            "The full list of available KEYs is below"
        ]),
        
        SyntaxItem(headline: "newline", paragraphs: [
            "Inserts a single newline",
        ]),
        
        SyntaxItem(headline: "newline|NUMBER", paragraphs: [
            "Inserts the specified number of newline. For example, this inserts 5 newlines:",
            "newline|5"
        ]),
        
        SyntaxItem(headline: "pause|SECONDS.SUBSECONDS", paragraphs: [
            "Pauses for the given time before moving to the next line. For example, this pauses for 1.2 seconds",
            "pause|1.2",
            "TODO: Figure out of paues without subseconds (e.g. `pause|1` works)"
        ]),
        
        SyntaxItem(headline: "press|KEY", paragraphs: [
            "Presses a single key (e.g. single letter, number, or functional key like arrow keys, delete, escape, or function keys. See below for full list). For example:",
            "press|delete"
        ]),
        
        SyntaxItem(headline: "reset-delay", paragraphs: [
            "Resets the delay between each character to the default",
        ]),
        
        SyntaxItem(headline: "set-delay|MIN|MAX", paragraphs: [
            "Sets the minimum and maximum delay time between typed characters",
            "The delay between each character is a random value between a min and max setting to add some variability into the typing speed. The defaults are 0.03 and 0.05. You can change the values with `set-delay` to make them slower or faster. For example:",
            "set-delay|0.1|0.2\nset-delay|0.01|0.01",
            "The first one slows things down. The second speeds them up compared to the default and removes the varaibility since the min and max are the same",
        ]),
        
    ]
    
    let helpStuff: [[String]] = [
        ["debug|on", "Remove all pauses to fast-forward until `debug|off` or the end of the script"],
        ["debug|off", "Restores all pauses so script runs at normal speed"],
        ["hold|command|a", "Holds down the `command` key and presses `a`"],
        ["newline", "Adds a single newline"],
        ["pause|0.9", "Pause for 0.9 seconds"],
    ]
    

//    } else if action == "stop" {
//        doStop()
//    } else if action == "type" {
//        doTypeCharacters(input: String(parts[1]))
//    } else if action == "type-line" {
//        if parts.count > 1 {
//            doTypeLine(input: String(parts[1]))
//        } else {
//            doTypeLine(input: "")
//        }
//    } else {
//        print("skipping unknown")
//        processLine()
//    }
    
    
    
    
//            ScrollView{
//                VStack{
//                    var usageStuff: AttributedString {
//                        var text = AttributedString("Usage\n")
//                        text.font = .title
//                        text.append(AttributedString("\n- Create a .txt file with a script in it (see below for the script syntax)"))
//                        return text
//                    }
//                    Text(usageStuff).frame(maxWidth: .infinity, alignment: .leading)
//                    Divider()
//
//                    var exampleScript: AttributedString {
//                        var text = AttributedString("Example Script\n")
//                        text.font = .title
//                        text.append(AttributedString("\nhold|command|a\n"))
//                        text.append(AttributedString("press|delete\n"))
//                        text.append(AttributedString("pause|1.5\n"))
//                        text.append(AttributedString("type-line|Hello, World!\n"))
//                        return text
//                    }
//                    Text(exampleScript).frame(maxWidth: .infinity, alignment: .leading)
//
//                    Divider()
//
//                    var scriptSyntaxHeadline: AttributedString {
//                        var text = AttributedString("\nScript Syntax")
//                        text.font = .title
//                        return text
//                    }
//                    Text(scriptSyntaxHeadline).frame(maxWidth: .infinity, alignment: .leading)
//
//                    ForEach(syntaxItems) { syntaxItem in
//                        var syntaxItemHeadline: AttributedString {
//                            var text = AttributedString("\n" + syntaxItem.headline + "\n")
//                            text.font = .headline
//                            for paragraph in syntaxItem.paragraphs {
//                                text.append(AttributedString("\n" + paragraph + "\n"))
//                            }
//                            return text
//                        }
//                        Text(syntaxItemHeadline).frame(maxWidth: .infinity, alignment: .leading)
//                        Divider()
//                    }
//
//                    var keysHeadline: AttributedString {
//                        var text = AttributedString("\nAvailable Keys")
//                        text.font = .title
//                        text.append(AttributedString("\n\nThese are the keys you can use for `press` and `hold` lines in your scripts:\n"))
//                        text.append(AttributedString("\n\nTODO: Add keys"))
//                        return text
//                    }
//                    Text(keysHeadline).frame(maxWidth: .infinity, alignment: .leading)
//
//                }
//            }.frame(maxWidth: .infinity).padding()
    
    
    
    
    var body: some View {
        ScrollView{
            VStack{
                var usageStuff: AttributedString {
                    var text = AttributedString("Usage\n")
                    text.font = .title
                    text.append(AttributedString("\n1. Create a .txt file with a script in it (see 'Examples' for ideas).\n\n"))
                    text.append(AttributedString("2. Use the 'Choose Script' button to select your script file.\n\n"))
                    text.append(AttributedString("3. Click on the app you want to output the script to in the 'Select App' section.\n\n"))
                    text.append(AttributedString("4. Click 'Run'. You may be asked to allow the app permissions in the System Preferences. This is required to let AutoTyper simulate a keyboard to do that actual typing. (Note that sometimes you have to delete the AutoTyper item, click Run, and turn it back on to reset it.)\n\n"))
                    return text
                }
                Text(usageStuff).frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
                
            }
            
        }.padding()
    }
}

struct ExamplesView: View{
//    var statusLine: String = "Status"
//    var statusArea: String = "Status area"
    var body: some View {
        VStack{
            Text("Examples").frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            ScrollView {
//                Text(statusArea).frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }.padding()
    }
}


struct ContentView: View {
    @State var appToWriteTo: NSRunningApplication?
    @State var charactersToType: [String] = []
    @State var codesToType: [UInt16] = []
    @State var scriptLines: [Substring] = []
    @State var holdCommand = false
    @State var holdControl = false
    @State var holdOption = false
    @State var holdShift = false
    @State var defaultMinDelay = 0.03
    @State var defaultMaxDelay = 0.05
    @State var minDelay = 0.03
    @State var maxDelay = 0.05
    @State var debugMinHold = 0.03
    @State var debugMaxHold = 0.05
    @State var debugging = false
    @State var hasPermissions = AXIsProcessTrusted()
    @State var selectedAppName = "Not Selected"
    @State var scriptUrl: Optional<URL> = Optional.none
    @State var selectedAppPid: Optional<pid_t> = Optional.none
    @State var statusLine = "Status: Ready"
    @State var statusArea = ""
    @State var errors: [String] = []
    @State var isPaused = false
    
    let keyCodes: [String: (UInt16, [CGEventFlags])] = [
        // NOTE: The arrows is special, they are for
        // type-down which is used in conjunction with
        // creating a bunch of pre-existing newlines
        // to prevent the scrollbar flashing when
        // the script types.
        "down-arrow": (0x7D, []),
        // These are the regular keys
        "0": (0x1D, []),
        ")": (0x1D, [.maskShift]),
        "1": (0x12, []),
        "!": (0x12, [.maskShift]),
        "2": (0x13, []),
        "@": (0x13, [.maskShift]),
        "3": (0x14, []),
        "#": (0x14, [.maskShift]),
        "4": (0x15, []),
        "$": (0x15, [.maskShift]),
        "5": (0x17, []),
        "%": (0x17, [.maskShift]),
        "6": (0x16, []),
        "^": (0x16, [.maskShift]),
        "7": (0x1A, []),
        "&": (0x1A, [.maskShift]),
        "8": (0x1C, []),
        "*": (0x1C, [.maskShift]),
        "9": (0x19, []),
        "(": (0x19, [.maskShift]),
        "a": (0x00, []),
        "A": (0x00, [.maskShift]),
        "b": (0x0B, []),
        "B": (0x0B, [.maskShift]),
        "c": (0x08, []),
        "C": (0x08, [.maskShift]),
        "d": (0x02, []),
        "D": (0x02, [.maskShift]),
        "e": (0x0E, []),
        "E": (0x0E, [.maskShift]),
        "f": (0x03, []),
        "F": (0x03, [.maskShift]),
        "g": (0x05, []),
        "G": (0x05, [.maskShift]),
        "h": (0x04, []),
        "H": (0x04, [.maskShift]),
        "i": (0x22, []),
        "I": (0x22, [.maskShift]),
        "j": (0x26, []),
        "J": (0x26, [.maskShift]),
        "k": (0x28, []),
        "K": (0x28, [.maskShift]),
        "l": (0x25, []),
        "L": (0x25, [.maskShift]),
        "m": (0x2E, []),
        "M": (0x2E, [.maskShift]),
        "n": (0x2D, []),
        "N": (0x2D, [.maskShift]),
        "o": (0x1F, []),
        "O": (0x1F, [.maskShift]),
        "p": (0x23, []),
        "P": (0x23, [.maskShift]),
        "q": (0x0C, []),
        "Q": (0x0C, [.maskShift]),
        "r": (0x0F, []),
        "R": (0x0F, [.maskShift]),
        "s": (0x01, []),
        "S": (0x01, [.maskShift]),
        "t": (0x11, []),
        "T": (0x11, [.maskShift]),
        "u": (0x20, []),
        "U": (0x20, [.maskShift]),
        "v": (0x09, []),
        "V": (0x09, [.maskShift]),
        "w": (0x0D, []),
        "W": (0x0D, [.maskShift]),
        "x": (0x07, []),
        "X": (0x07, [.maskShift]),
        "y": (0x10, []),
        "Y": (0x10, [.maskShift]),
        "z": (0x06, []),
        "Z": (0x06, [.maskShift]),
        "=": (0x18, []),
        "+": (0x18, [.maskShift]),
        "-": (0x1B, []),
        "_": (0x1B, [.maskShift]),
        "[": (0x21, []),
        "{": (0x21, [.maskShift]),
        "]": (0x1E, []),
        "}": (0x1E, [.maskShift]),
        "'": (0x27, []),
        "\"": (0x27, [.maskShift]),
        ";": (0x29, []),
        ":": (0x29, [.maskShift]),
        "\\": (0x2A, []),
        "|": (0x2A, [.maskShift]),
        ",": (0x2B, []),
        "<": (0x2B, [.maskShift]),
        "/": (0x2C, []),
        "?": (0x2C, [.maskShift]),
        ".": (0x2F, []),
        ">": (0x2F, [.maskShift]),
        "`": (0x32, []),
        "~": (0x32, [.maskShift]),
        " ": (0x31, []),
        "\n": (0x24, []),
        "\t": (0x30, []),
    ]
    
    let pressCodes: [String: (UInt16, String)] = [
        "=": (0x18, ""),
        "enter": (0x24, ""),
        "'": (0x27, ""),
        ",": (0x2B, ""),
        "-": (0x1B, ""),
        ".": (0x2F, ""),
        "/": (0x2C, ""),
        "0": (0x1D, ""),
        "1": (0x12, ""),
        "2": (0x13, ""),
        "3": (0x14, ""),
        "4": (0x15, ""),
        "5": (0x17, ""),
        "6": (0x16, ""),
        "7": (0x1A, ""),
        "8": (0x1C, ""),
        "9": (0x19, ""),
        ";": (0x29, ""),
        "[": (0x1E, ""),
        "\\": (0x2A, ""),
        "]": (0x21, ""),
        "a": (0x00, ""),
        "b": (0x0B, ""),
        "c": (0x08, ""),
        "caps-lock": (0x39, ""),
        "command": (0x37, ""),
        "control": (0x3B, ""),
        "d": (0x02, ""),
        "delete": (0x33, ""),
        "down-arrow": (0x7D, ""),
        "e": (0x0E, ""),
        "end": (0x77, ""),
        "escape": (0x35, ""),
        "f": (0x03, ""),
        "f1": (0x7A, ""),
        "f10": (0x6D, ""),
        "f11": (0x67, ""),
        "f12": (0x6F, ""),
        "f13": (0x69, ""),
        "f14": (0x6B, ""),
        "f15": (0x71, ""),
        "f16": (0x6A, ""),
        "f17": (0x40, ""),
        "f18": (0x4F, ""),
        "f19": (0x50, ""),
        "f2": (0x78, ""),
        "f20": (0x5A, ""),
        "f3": (0x63, ""),
        "f4": (0x76, ""),
        "f5": (0x60, ""),
        "f6": (0x61, ""),
        "f7": (0x62, ""),
        "f8": (0x64, ""),
        "f9": (0x65, ""),
        "forward-delete": (0x75, ""),
        "function": (0x3F, ""),
        "g": (0x05, ""),
        "h": (0x04, ""),
        "help": (0x72, ""),
        "home": (0x73, ""),
        "i": (0x22, ""),
        "iso-section": (0x0A, ""),
        "j": (0x26, ""),
        "jis-eisu": (0x66, ""),
        "jis-underscore": (0x5E, ""),
        "jis-yen": (0x5D, ""),
        "jis_kana": (0x68, ""),
        "k": (0x28, ""),
        "keypad-0": (0x52, ""),
        "keypad-1": (0x53, ""),
        "keypad-2": (0x54, ""),
        "keypad-3": (0x55, ""),
        "keypad-4": (0x56, ""),
        "keypad-5": (0x57, ""),
        "keypad-6": (0x58, ""),
        "keypad-7": (0x59, ""),
        "keypad-8": (0x5B, ""),
        "keypad-9": (0x5C, ""),
        "keypad-clear": (0x47, ""),
        "keypad-decimal": (0x41, ""),
        "keypad-divide": (0x4B, ""),
        "keypad-enter": (0x4C, ""),
        "keypad-equals": (0x51, ""),
        "keypad-jis-comma": (0x5F, ""),
        "keypad-minus": (0x4E, ""),
        "keypad-multiply": (0x43, ""),
        "keypad-plus": (0x45, ""),
        "l": (0x25, ""),
        "left-arrow": (0x7B, ""),
        "m": (0x2E, ""),
        "mute": (0x4A, ""),
        "n": (0x2D, ""),
        "o": (0x1F, ""),
        "option": (0x3A, ""),
        "p": (0x23, ""),
        "page-down": (0x79, ""),
        "page-up": (0x74, ""),
        "q": (0x0C, ""),
        "r": (0x0F, ""),
        "return": (0x24, ""),
        "right-arrow": (0x7C, ""),
        "s": (0x01, ""),
        "shift": (0x38, ""),
        "space": (0x31, ""),
        "t": (0x11, ""),
        "tab": (0x30, ""),
        "u": (0x20, ""),
        "up-arrow": (0x7E, ""),
        "v": (0x09, ""),
        "volume-down": (0x49, ""),
        "volume-up": (0x48, ""),
        "w": (0x0D, ""),
        "x": (0x07, ""),
        "y": (0x10, ""),
        "z": (0x06, ""),
        "~": (0x32, ""),
    ]
    
    func addError(parts: [String], message: String) {
        // TODO: Add errors
    }
    
    
    func checkPermissions() -> Bool {
        let options : NSDictionary = [
            // I've read the docs, but I don't understand the difference
            // between Unretained and Retained in terms of what it means
            // in this case. Unretained is doing what I want though.
            // Retained might as well, but haven't tested it yet since
            // Unretained is doing the thing.
            kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString: true,
//            kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true,
        ]
        return AXIsProcessTrustedWithOptions(options)
    }
    
    func chooseScript() {
        let picker = NSOpenPanel()
        picker.canChooseFiles = true
        picker.runModal()
        scriptUrl = picker.url
    }
    
    func delayTime() -> Double {
        if minDelay < maxDelay {
            return Double.random(in: minDelay..<maxDelay)
        } else {
            return minDelay
        }
    }
    
    func doDebug(parts: [String]) {
        if parts.count == 2 {
            let setting = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
            if setting == "on" {
                debugMinHold = minDelay
                debugMaxHold = maxDelay
                minDelay = 0
                maxDelay = 0
                debugging = true
            } else if setting == "off" {
                minDelay = debugMinHold
                maxDelay = debugMaxHold
                debugging = false
            }
        }
        processLine()
    }
    
    func doDown(parts: [String]) {
        if parts.count == 1 {
            charactersToType.append("down-arrow")
        } else {
            // TODO: Figure out how to throw an error here if
            // there's not a valid number
            let charactersDown = Int32(truncating: NumberFormatter().number(from: parts[1])!)
            for _ in (0..<charactersDown) {
                charactersToType.append("down-arrow")
            }
        }
        typeCharacter()
    }
    
    func doNewline(parts: [String]) {
        if parts.count == 1 {
            charactersToType.append("\n")
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime() * 3) {
                typeCharacter()
            }
        } else if parts.count >= 2 {
            let newlineCount = Int(parts[1]) ?? 1
            for _ in (0..<newlineCount) {
                charactersToType.append("\n")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime() * 3) {
                typeCharacter()
            }
        }
    }
    
    func doPasteFile(parts: [String]) {
        if parts.count == 2 {
            do {
                let fileUrl = URL(string: "file://" + parts[1])
                let contentToPaste = try String(contentsOf: fileUrl!, encoding: String.Encoding.utf8)
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(contentToPaste, forType: .string)
                let src = CGEventSource(stateID: .privateState)
                let doDown = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: true)
                let doUp = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: false)
                let flagList: [CGEventFlags] = [CGEventFlags.maskCommand]
                let flags: CGEventFlags = CGEventFlags.init(flagList)
                doDown?.flags = flags
                doUp?.flags = flags
                doDown?.postToPid(selectedAppPid!)
                doUp?.postToPid(selectedAppPid!)
            } catch{
                addError(parts: parts, message: "Could not copy file")
            }
        }
        processLine()
    }
    
    func doPause(parts: [String]) {
        if parts.count == 1 {
            isPaused = true
            statusLine = "Status: Paused. Press F2 to resume"
        } else {
            if debugging == false {
                if parts.count == 2 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + (Double(parts[1]) ?? 0.0)) {
                        processLine()
                    }
                }
                else {
                    // TODO: Error about not having pause value
                    processLine()
                }
            } else {
                processLine()
            }
        }
    }
    
    func doPress(parts: [String]) {
        if parts.count > 1 {
            let keyToGet = parts.last!.trimmingCharacters(in: .whitespacesAndNewlines)
            if keyToGet != "" {
                if let pressCode = pressCodes[keyToGet] {
                    codesToType.append(pressCode.0)
                    // Add modifiers if there are any
                    if parts.count > 2 {
                        var trimmedParts = parts
                        let _ = trimmedParts.popLast()
                        trimmedParts.reverse()
                        let _ = trimmedParts.popLast()
                        for trimmedPart in trimmedParts {
                            if trimmedPart == "command" {
                                holdCommand = true
                            } else if trimmedPart == "control" {
                                holdControl = true
                            } else if trimmedPart == "option" {
                                holdOption = true
                            } else if trimmedPart == "shift" {
                                holdShift = true
                            }
                        }
                    }
                } else {
                    addError(parts: parts, message: "Value not an available character to press")
                }
                typeCode()
            } else {
                addError(parts: parts, message: "No value sent to press")
            }
        } else {
            addError(parts: parts, message: "No value sent to press")
        }
    }
    
    func doRepeat(parts: [String]) {
        // TODO: Add error if the value that is sent for
        // the number isn't a number
        if parts.count > 2 {
            let keyToGet = parts.last!.trimmingCharacters(in: .whitespacesAndNewlines)
            let repeatCount = Int32(truncating: NumberFormatter().number(from: parts[1])!)
            if keyToGet != "" {
                if let pressCode = pressCodes[keyToGet] {
                    for _ in (1...repeatCount) {
                        codesToType.append(pressCode.0)
                    }
                    // Add modifiers if there are any
                    if parts.count > 3 {
                        var trimmedParts = parts
                        let _ = trimmedParts.popLast()
                        trimmedParts.reverse()
                        let _ = trimmedParts.popLast()
                        let _ = trimmedParts.popLast()
                        for trimmedPart in trimmedParts {
                            if trimmedPart == "command" {
                                holdCommand = true
                            } else if trimmedPart == "control" {
                                holdControl = true
                            } else if trimmedPart == "option" {
                                holdOption = true
                            } else if trimmedPart == "shift" {
                                holdShift = true
                            }
                        }
                    }
                } else {
                    addError(parts: parts, message: "Value not an available character to press")
                }
                typeCode()
            } else {
                addError(parts: parts, message: "No value sent to press")
            }
        } else {
            addError(parts: parts, message: "No value sent to press")
        }
    }
    
    func doResetDelay() {
        minDelay = defaultMinDelay
        maxDelay = defaultMaxDelay
        processLine()
    }
    
    func doSetDelay(parts: [String]) {
        // TODO: Add error message if converstion to double fails
        if parts.count == 3 {
            minDelay = Double(parts[1]) ?? defaultMinDelay
            maxDelay = Double(parts[2]) ?? defaultMaxDelay
        } else if parts.count == 2 {
            minDelay = Double(parts[1]) ?? defaultMinDelay
            maxDelay = Double(parts[1]) ?? defaultMaxDelay
        } else {
            // TODO: Show Error message
        }
        processLine()
    }
    
    func doStop() {
        // TODO: Show messages that you hit a stop
    }
    
    func doTypeCharacters(input: String) {
        var charactersToLoad = input.split(separator: "")
        charactersToLoad.reverse()
        for x in charactersToLoad {
            charactersToType.append(String(x))
        }
        typeCharacter()
    }
    
    func doTypeDown(parts: [String]) {
        if parts.count > 1 {
            // TODO: Deal with `|` coming in that need to be typed
            var charactersToLoad = parts[1].split(separator: "")
            charactersToLoad.append("down-arrow")
            charactersToLoad.reverse()
            for x in charactersToLoad {
                charactersToType.append(String(x))
            }
            typeCharacter()
        }
    }
    
    func doTypeLine(input: String) {
        var charactersToLoad = input.split(separator: "")
        charactersToLoad.append("\n")
        charactersToLoad.reverse()
        for x in charactersToLoad {
            charactersToType.append(String(x))
        }
        typeCharacter()
    }
    
    func processLine() {
        holdCommand = false
        holdControl = false
        holdShift = false
        holdOption = false
        if scriptLines.count > 0 {
            statusLine = "Status: Running..."
            let line = scriptLines.popLast()
//            print(line as Any)
            let parts_substrings = line?.split(separator: "|")
            var parts: [String] = []
            for part in parts_substrings! {
                parts.append(String(part))
            }
            let action = parts[0]
            if action == "debug" {
                doDebug(parts: parts)
//            } else if action == "hold" {
//                doHold(parts: parts)
            } else if action == "newline" {
                doNewline(parts: parts)
            } else if action == "paste-file" {
                doPasteFile(parts: parts)
            } else if action == "pause" {
                doPause(parts: parts)
            } else if action == "press" {
                doPress(parts: parts)
            } else if action == "repeat" {
                doRepeat(parts: parts)
            } else if action == "reset-delay" {
                doResetDelay()
            } else if action == "set-delay" {
                doSetDelay(parts: parts)
            } else if action == "stop" {
                doStop()
            } else if action == "type" {
                // TODO: Send 'parts' so they can be
                // combined if there's more than one
                // separated by a `|`
                doTypeCharacters(input: String(parts[1]))
            } else if action == "type-down" {
                doTypeDown(parts: parts)
            } else if action == "type-line" {
                // TODO: Send 'parts' so they can be
                // combined if there's more than one
                // separated by a `|`
                if parts.count > 1 {
                    doTypeLine(input: String(parts[1]))
                } else {
                    doTypeLine(input: "")
                }
            } else {
                processLine()
            }
        } else {
            statusLine = "Status: Process complete"
        }
    }
    
    func runningApps() -> [PotentialApp] {
        let kCGNullWindowID: UInt32 = 0
        guard let windows = CGWindowListCopyWindowInfo([.optionOnScreenOnly], kCGNullWindowID) as NSArray? as? [[String: AnyObject]] else {
            return []
        }
        var filteredWindows: [pid_t] = []
        windows.forEach {
            let ownerPid = $0[kCGWindowOwnerPID as String] as! pid_t
            let ownerName = $0[kCGWindowOwnerName as String] as! String
            if ownerName != "Dock" && ownerName != "Window Server" {
                if !filteredWindows.contains(ownerPid) {
                    filteredWindows.append(ownerPid)
                }
            }
        }
        let baseApps = NSWorkspace.shared.runningApplications
        let initialFilteredApps = baseApps.filter {checkApp in
            filteredWindows.contains(checkApp.processIdentifier)
        }
            .sorted(by: {
                $0.localizedName?.lowercased() ?? "unknown name" < $1.localizedName?.lowercased() ?? "unknown name"})
            .map{ PotentialApp(app: $0, id: $0.processIdentifier)}
        return initialFilteredApps
    }
    
    func runScript() {
        minDelay = defaultMinDelay
        maxDelay = defaultMaxDelay
        holdCommand = false
        holdControl = false
        holdOption = false
        holdShift = false
        if scriptUrl == Optional.none {
            statusLine = "Status: Choose a script file first"
        } else if selectedAppPid == Optional.none {
            statusLine = "Status: Choose an app first"
        } else if checkPermissions() == false {
            statusLine = "Status: Provide permissions then Run again"
        } else {
            NSEvent.addGlobalMonitorForEvents(matching: [.keyDown]) { (event) in
                if isPaused == true && event.keyCode == 0x78 {
                    isPaused = false
                    processLine()
                }
            }
            do {
                let scriptContents =
                try String(contentsOf: scriptUrl!, encoding: String.Encoding.utf8)
                NSWorkspace.shared.runningApplications.forEach{ checkApp in
                    if checkApp.processIdentifier == selectedAppPid! {
                        checkApp.activate()
                    }
                }
                scriptLines = scriptContents.split(separator: "\n")
                scriptLines.reverse()
                processLine()
            } catch{
                statusLine = "Status: ERROR: Could not open file"
            }
        }
    }
    
    
    func typeCharacterInApp(theCharacter: String) {
        let parts = keyCodes[theCharacter]!
        let src = CGEventSource(stateID: .privateState)
        let doDown = CGEvent(keyboardEventSource: src, virtualKey: parts.0, keyDown: true)
        let doUp = CGEvent(keyboardEventSource: src, virtualKey: parts.0, keyDown: false)
        var flagList = parts.1
        if holdCommand == true {
            flagList.append(CGEventFlags.maskCommand)
        }
        if holdControl == true {
            flagList.append(CGEventFlags.maskControl)
        }
        if holdOption == true {
            flagList.append(CGEventFlags.maskAlternate)
        }
        if holdShift == true {
            flagList.append(CGEventFlags.maskShift)
        }
        let flags: CGEventFlags = CGEventFlags.init(flagList)
        doDown?.flags = flags
        doUp?.flags = flags
        doDown?.postToPid(selectedAppPid!)
        doUp?.postToPid(selectedAppPid!)
        if charactersToType.count > 0 {
            typeCharacter()
        } else {
            processLine()
        }
    }
    
    func typeCodeInApp(theCode: UInt16) {
        let src = CGEventSource(stateID: .privateState)
        let doDown = CGEvent(keyboardEventSource: src, virtualKey: theCode, keyDown: true)
        let doUp = CGEvent(keyboardEventSource: src, virtualKey: theCode, keyDown: false)
        var flagList: [CGEventFlags] = []
        if holdCommand == true {
            flagList.append(CGEventFlags.maskCommand)
        }
        if holdControl == true {
            flagList.append(CGEventFlags.maskControl)
        }
        if holdOption == true {
            flagList.append(CGEventFlags.maskAlternate)
        }
        if holdShift == true {
            flagList.append(CGEventFlags.maskShift)
        }
        let flags: CGEventFlags = CGEventFlags.init(flagList)
        doDown?.flags = flags
        doUp?.flags = flags
        doDown?.postToPid(selectedAppPid!)
        doUp?.postToPid(selectedAppPid!)
        if codesToType.count > 0 {
            typeCode()
        } else {
            processLine()
        }
    }
    
    func typeCharacter() {
        if charactersToType.count > 0 {
            let theCharacter = charactersToType.popLast()!
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime()) {
                self.typeCharacterInApp(theCharacter: theCharacter)
            }
        }
    }
    
    func typeCode() {
        if codesToType.count > 0 {
            let theCode = codesToType.popLast()!
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime()) {
                self.typeCodeInApp(theCode: theCode)
            }
        }
    }
    
    func getUrlFileName() -> String {
        let urlFileName: String? = scriptUrl?.lastPathComponent
        if urlFileName == Optional.none {
            return "none"
        } else {
            return urlFileName!
        }
    }
    
    var body: some View {
        HStack{
            VStack {
                HStack {
                    Button("Choose Script") {
                        chooseScript()
                    }
                    Text(getUrlFileName()).frame(maxWidth: .infinity, alignment: .leading)
                }
                Divider()
                Text("Select App").frame(maxWidth: .infinity, alignment: .leading)
                List(runningApps(), selection: $selectedAppPid) {
                    Text($0.app.localizedName ?? "unknown name")
                }
                Divider()
                Button("Run") {
                    runScript()
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }.frame(maxWidth: .infinity).padding()
            Divider()
            VStack {
                TabView{
                    StatusView(statusLine: statusLine, statusArea: statusArea).tabItem {Text("Status") }
                    DocsView().tabItem { Text("Documentation") }
                    ExamplesView().tabItem { Text("Examples") }
                }
                Spacer()
            }.padding()
        }
    }
}

#Preview {
    ContentView()
}
