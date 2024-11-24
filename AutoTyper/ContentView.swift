//
//  ContentView.swift
//  AutoTyper
//
//  Created by Alan W. Smith on 11/21/24.
//

import AVKit
import SwiftUI

// TODO: Rename "script" stuff to "instructions"

// TODO: Rename "command" stuff to "instruction"

// TODO: Handle unknow characters

// TODO: Do a check for persmissions where it counts
// the number of times you've tried and tells you to delete
// things if necessary. Or, probably even better, update the
// Status tab to show what you need to do.

struct AVPlayerControllerRepresented : NSViewRepresentable {
    var player : AVPlayer
    
    func makeNSView(context: Context) -> AVPlayerView {
        let view = AVPlayerView()
        view.controlsStyle = .none
        view.player = player
        return view
    }
    
    func updateNSView(_ nsView: AVPlayerView, context: Context) {
        // This space was blank in the example. Not
        // sure if it's required or just stubbed out for
        // potential usage. I'm leaving it in regardless.
    }
}

struct ErrorPayload {
    let line: String
    let message: String
}

struct ExampleItem: Identifiable, Hashable {
    let title: String
    let basename: String
    let num: Int32
//    let description: [String]
    let id = UUID()
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
        SyntaxItem(headline: "debug: on", paragraphs: [
            "Remove all delays and pauses to fast-forward until `debug: off` or the end of the script.",
        ]),
        
        SyntaxItem(headline: "debug: off", paragraphs: [
            "Restores all pauses so script runs at specified delays and pauses.",
        ]),
        
        SyntaxItem(headline: "newline", paragraphs: [
            "This version of 'newline' doesn't have a ':' or number after it. It inserts a single newline.",
        ]),
        
        SyntaxItem(headline: "newline: NUMBER", paragraphs: [
            "Inserts the specified number of newlines. For example, this inserts 5 newlines:",
            "newline: 5"
        ]),
        
        SyntaxItem(headline: "paste-file: FILE_PATH", paragraphs: [
            "Copies the contents of the file at 'FILE_PATH' and pastes it in directly. For example, this pastes the contents of a 'code.txt' file on my Desktop:",
            "paste-file: /Users/alan/Desktop/code.txt",
            "An easy way to get the FILE_PATH for a file is to right click on it in the Finder then hold the 'Option' key. The 'Copy' option turns into 'Copy ... as Pathname' which gives you what you need for the FILE_PATH.",
        ]),
        
        SyntaxItem(headline: "pause", paragraphs: [
            "This is the version of 'pause' that doesn't have a ':' or number after it. It pauses the script fully.",
            "Press the F2 key to resume the script.",
            "This is designed to make it easier to do live recordings of scripts where you have everything set up and then use the pause/F2 process to add break points for talking.",
            "Depending on how you mac is set up, you'll need to hold down the 'fn' key when you press 'F2' to get it to trigger instead of changing the brightness of your screen.",
        ]),
        
        SyntaxItem(headline: "pause: NUMBER", paragraphs: [
            "Pause for a specific amount of time. For example, this pauses for 1.2 seconds",
            "pause: 1.2",
            "I use this to add some padding between blocks of code that are output together which I find makes them easier to follow."
        ]),
        
        SyntaxItem(headline: "press: KEY", paragraphs: [
            "Presses a single key on the keyboard.",
            "This can be used for pressing keys like 'escape', or arrow keys. For example:",
            "press: escape\npress: down-arrow",
            "The full list of KEYs is listed in the 'Keys' tab."
        ]),
        
        SyntaxItem(headline: "press: MODIFIERS: KEY", paragraphs: [
            "Presses a single key on the keyboard while holding the specified MODIFIERS. For example, this will type 'Command + a' which does a select all in apps like VS Code:",
            "press: command: a",
            "Multiple MODIFIERS can be used by separating them with ':' characters. For example, this does 'Command + Shift + Left Arrow' which selects the prior word in apps like VS Code:",
            "press: command: shift: left-arrow",
            "The available MODIFIERS are:",
            "- command\n- control\n- option\n- shift",
            "The full list of KEY is listed in the 'Keys' tab."
        ]),
        
        SyntaxItem(headline: "repeat: NUMBER: KEY", paragraphs: [
            "Works the same as 'press: KEY' but repeats the press NUMBER of times. For example:",
            "repeat: 5: left-arrow",
        ]),
        
        SyntaxItem(headline: "repeat: MODIFIERS: KEY", paragraphs: [
            "Works the same as 'press: MODIFIERS: KEY' but repeats the press NUMBER of times. For example:",
            "repeat: 5: command: shift: left-arrow",
        ]),
        
        SyntaxItem(headline: "reset-delay", paragraphs: [
            "Resets the minimum and maximum times for the randomized delay between keystokes to their default values '0.01' and '0.03'",
        ]),
        
        SyntaxItem(headline: "set-delay: NUMBER", paragraphs: [
            "Set the delay between keystrokes to NUMBER. For example:",
            "set-delay: 0.07",
        ]),
        
        SyntaxItem(headline: "set-delay: MIN: MAX", paragraphs: [
            "Set the minimum and maximum times for the randomized delay between keystokes to the values defined in MIN and MAX. For example:",
            "set-delay: 0.05: 0.1",
        ]),
        
        SyntaxItem(headline: "stop", paragraphs: [
            "Stops the script.",
            "I use this in conjunction with 'debug: on' to fast forward to a part of a script I want to check and then halt it there so I can verify the output.",
        ]),
        
        SyntaxItem(headline: "type: STRING", paragraphs: [
            "Type the STRING of text without adding a newline or pressing the down arrow. This can be used for things like typing part of a line then doing a pause or changing the delay before finishing it.",
            "Note: only the characters available in the 'Typing Keys' section of 'Key Names' can be used. If you need to type something else, you'll need to use 'press: MODIFIERS: KEY' (e.g. 'press: option: 2' to type the ™ symbol)",
            "Note: I wrote AutoTyper for my U.S. English keyboard. I'm not opposed to making a more international version, but I don't know what that would take and don't have the resources to look into right now.",
        ]),
        
        SyntaxItem(headline: "type-down: STRING", paragraphs: [
            "Same as 'type: STRING' but presses the down arrow key after the STRING is complete.",
            "I generally use this instead of 'type-line: STRING' when I'm using VS Code.",
            "Specifically, before I start the main script I run 'newline: 50' then 'press: command: up-arrow' which adds 50 blank lines to the file then moves the cursor to the top.",
            "Doing that and then using 'type-down: STRING' helps prevent the VS Code scrollbar from flashing as much. I find it less distracting that way.",
        ]),
        
        SyntaxItem(headline: "type-line: STRING", paragraphs: [
            "Same as 'type: STRING' but creates a newline after the STRING is complete.",
        ]),
        
    ]
    
    var body: some View {
        ScrollView{
            VStack{
                var usageStuff: AttributedString {
                    var text = AttributedString("Usage\n")
                    text.font = .title
                    text.append(AttributedString("\n1. Create a .txt file with instructions in it (see 'Examples' for ideas).\n\n"))
                    text.append(AttributedString("2. Use the 'Choose Instructions File' button to select your script file.\n\n"))
                    text.append(AttributedString("3. Click on the app you want to output the script to in the 'Select App' section.\n\n"))
                    text.append(AttributedString("4. Click 'Run'. You may be asked to allow the app permissions in the System Preferences. This is required to let AutoTyper simulate a keyboard to do that actual typing. (Note that sometimes you have to delete the AutoTyper item, click Run, and turn it back on to reset it.)\n\n"))
                    return text
                }
                Text(usageStuff).frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                var stoppingNote:AttributedString {
                    var text = AttributedString("Stopping\n")
                    text.font = .title
                    text.append(AttributedString("\nYou can stop the typing at any time by changing to any app other than the one that's being typed into."))
                    return text
                }
                Text(stoppingNote).frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                
                var scriptSyntaxHeadline: AttributedString {
                    var text = AttributedString("\nScript Commands")
                    text.font = .title
                    return text
                }
                Text(scriptSyntaxHeadline).frame(maxWidth: .infinity, alignment: .leading)
                ForEach(syntaxItems) { syntaxItem in
                    var syntaxItemHeadline: AttributedString {
                        var text = AttributedString("\n" + syntaxItem.headline + "\n")
                        text.font = .title3.bold()
                        for paragraph in syntaxItem.paragraphs {
                            text.append(AttributedString("\n" + paragraph + "\n"))
                        }
                        return text
                    }
                    Text(syntaxItemHeadline).frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                }
            }
        }.padding()
    }
}

struct KeysView: View {
    let pressCodes: [String: (UInt16, String)]
    
    func sortStuff() -> [String] {
        []
    }
    
    var body: some View {
        VStack{
            
            var titleStuff: AttributedString {
                var text = AttributedString("Key Names\n")
                text.font = .title
                text.append(AttributedString("\nThese are the KEYs you can use for 'press' and 'repeat' commands.\n\n"))
                return text
            }
            Text(titleStuff).frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView {
                ForEach(Array(pressCodes.keys.sorted()), id: \.self) { item in
                    Text(item).frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
    }
}

struct ExamplesView: View {
    let exampleItems: [ExampleItem] = [
        
        ExampleItem(
            title: "type: TEXT",
            basename: "01-type",
            num: 1
        ),
        
        ExampleItem(
            title: "press: KEY",
            basename: "02-press",
            num: 2
        ),
        
        ExampleItem(
            title: "press: MODIFIERS: KEY",
            basename: "03-press-mod",
            num: 3
        ),
        
        ExampleItem(
            title: "repeat: NUMBER: KEY",
            basename: "04-repeat",
            num: 4
        ),
        
        ExampleItem(
            title: "repeat: NUMBER: MODIFIERS: KEY",
            basename: "05-repeat-mod",
            num: 5
        ),
        
        ExampleItem(
            title: "newline",
            basename: "06-newline",
            num: 6
        ),
        
        ExampleItem(
            title: "newline: NUMBER",
            basename: "07-newline-multi",
            num: 7
        ),
        
        ExampleItem(
            title: "pause",
            basename: "08-pause",
            num: 8
        ),
        
        ExampleItem(
            title: "pause: NUMBER",
            basename: "09-pause-num",
            num: 9
        ),
        
        ExampleItem(
            title: "type-line: TEXT",
            basename: "10-type-line",
            num: 10
        ),
        
    ]
    
    func getTextFromFile(basename: String, key: String) -> String {
        do {
            if let exampleScriptUrl = Bundle.main.url(forResource: "\(basename)-\(key)", withExtension: "txt") {
                let exampleScriptText = try String(contentsOf: exampleScriptUrl, encoding: String.Encoding.utf8)
                return exampleScriptText
            } else {
                return "Could not open file"
            }
        } catch {
            return "Could not open file"
        }
    }
    
    let playerDidFinishNotification = NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)

    var body: some View {
        TabView{
            ForEach(exampleItems) { exampleItem in
                ScrollView {
                    VStack {
                        let scriptContents = getTextFromFile(basename: exampleItem.basename, key: "script")
                        let descContents = getTextFromFile(basename: exampleItem.basename, key: "desc")
                        
                        // The Example Number And Title
                        var exampleItemHeadline: AttributedString {
                            var text = AttributedString("\n" + exampleItem.title + "\n")
                            text.font = .title3.bold()
                            return text
                        }
                        Text(exampleItemHeadline).frame(maxWidth: .infinity, alignment: .leading)
                        // TODO: Figure out how to get the isplaying stuff
                        // working. The original version was for a single
                        // video so need something that can deal with
                        // multiple ones on the same page. But for now,
                        // the clips are short enough that it doesn't
                        // matter
                        @State var isPlaying: Bool = false
                        // The video player or "No video" fallback
                        if let url = Bundle.main.url(forResource: "\(exampleItem.basename)-video", withExtension: "mp4") {
                            let player = AVPlayer(url: url)
                            HStack {
                                AVPlayerControllerRepresented(player: player)
                                    .frame(height: 210)
                                    .disabled(true)
                                Button {
                                    if isPlaying == true {
                                        player.pause()
                                    } else {
                                        player.seek(to: .zero)
                                        player.play()
                                    }
                                    isPlaying.toggle()
                                } label: {
                                    Image(systemName: isPlaying ? "stop" : "play")
                                        .padding()
                                }.onReceive(playerDidFinishNotification, perform: { _ in
                                    isPlaying = false
                                })
                            }
                        } else {
                            Text("No video")
                        }
                        var scriptHeadline: AttributedString {
                            var text = AttributedString("\nScript")
                            text.font = .headline
                            return text
                        }
                        Text(scriptHeadline).frame(maxWidth: .infinity, alignment: .leading)
                        Divider()
                        HStack {
                            Text(scriptContents)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                            Button {
                                NSPasteboard.general.clearContents()
                                NSPasteboard.general.setString(scriptContents, forType: .string)
                            } label: {
                                Image(systemName: "doc.on.doc").padding()
                            }
                        }
                        Divider()
                        var descHeadline: AttributedString {
                            var text = AttributedString("\nDescription\n")
                            text.font = .headline
                            return text
                        }
                        Text(descHeadline).frame(maxWidth: .infinity, alignment: .leading)
                        let exampleItemParagraphs = AttributedString(descContents)
                        Text(exampleItemParagraphs)
                    }
                }.tabItem { Text(String(exampleItem.num)) }
            }.padding()
        }
    }
}

struct Examples2View: View {
    let exampleItems: [ExampleItem] = [
        
        ExampleItem(
            title: "type-down: TEXT",
            basename: "11-type-down",
            num: 11
        ),
        
        ExampleItem(
            title: "paste-file: PATH",
            basename: "12-paste-file",
            num: 12
        ),
        
        ExampleItem(
            title: "debug: on | debug: off",
            basename: "13-debug",
            num: 13
        ),
        
        ExampleItem(
            title: "set-delay: NUMBER | set-delay: MIN: MAX",
            basename: "14-set-delay",
            num: 14
        ),
        
        ExampleItem(
            title: "reset-delay",
            basename: "15-reset-delay",
            num: 15
        ),
        
        ExampleItem(
            title: "stop",
            basename: "16-stop",
            num: 16
        ),
        
        ExampleItem(
            title: "Full Example",
            basename: "17-full-1",
            num: 17
        ),
        
    ]
    
    func getTextFromFile(basename: String, key: String) -> String {
        do {
            if let exampleScriptUrl = Bundle.main.url(forResource: "\(basename)-\(key)", withExtension: "txt") {
                let exampleScriptText = try String(contentsOf: exampleScriptUrl, encoding: String.Encoding.utf8)
                return exampleScriptText
            } else {
                return "Could not open file"
            }
        } catch {
            return "Could not open file"
        }
    }
    
    let playerDidFinishNotification = NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)

    var body: some View {
        TabView{
            ForEach(exampleItems) { exampleItem in
                ScrollView {
                    VStack {
                        let scriptContents = getTextFromFile(basename: exampleItem.basename, key: "script")
                        let descContents = getTextFromFile(basename: exampleItem.basename, key: "desc")
                        
                        // The Example Number And Title
                        var exampleItemHeadline: AttributedString {
                            var text = AttributedString("\n" + exampleItem.title + "\n")
                            text.font = .title3.bold()
                            return text
                        }
                        Text(exampleItemHeadline).frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        // TODO: Figure out how to get the isplaying stuff
                        // working. The original version was for a single
                        // video so need something that can deal with
                        // multiple ones on the same page. But for now,
                        // the clips are short enough that it doesn't
                        // matter
                        @State var isPlaying: Bool = false
                        
                        // The video player or "No video" fallback
                        if let url = Bundle.main.url(forResource: "\(exampleItem.basename)-video", withExtension: "mp4") {
                            let player = AVPlayer(url: url)
                            HStack {
                                AVPlayerControllerRepresented(player: player)
                                    .frame(height: 210)
                                    .disabled(true)
                                Button {
                                    if isPlaying == true {
                                        player.pause()
                                    } else {
                                        player.seek(to: .zero)
                                        player.play()
                                    }
                                    isPlaying.toggle()
                                } label: {
                                    Image(systemName: isPlaying ? "stop" : "play")
                                        .padding()
                                }.onReceive(playerDidFinishNotification, perform: { _ in
                                    isPlaying = false
                                })
                            }
                        } else {
                            Text("No video")
                        }
                        var scriptHeadline: AttributedString {
                            var text = AttributedString("\nScript")
                            text.font = .headline
                            return text
                        }
                        Text(scriptHeadline).frame(maxWidth: .infinity, alignment: .leading)
                        Divider()
                        HStack {
                            Text(scriptContents)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                            Button {
                                NSPasteboard.general.clearContents()
                                NSPasteboard.general.setString(scriptContents, forType: .string)
                            } label: {
                                Image(systemName: "doc.on.doc").padding()
                            }
                        }
                        Divider()
                        var descHeadline: AttributedString {
                            var text = AttributedString("\nDescription\n")
                            text.font = .headline
                            return text
                        }
                        Text(descHeadline).frame(maxWidth: .infinity, alignment: .leading)
                        let exampleItemParagraphs = AttributedString(descContents)
                        Text(exampleItemParagraphs)
                    }
                }.tabItem { Text(String(exampleItem.num)) }
            }.padding()
        }
    }
}

struct ContentView: View {
    @State var appToWriteTo: NSRunningApplication?
    @State var captureLines = false
    @State var captureLinesDown = false
    @State var charactersToType: [String] = []
    @State var codesToType: [UInt16] = []
    @State var debugging = false
    @State var debugMaxHold = 0.03
    @State var debugMinHold = 0.01
    @State var defaultMaxDelay = 0.03
    @State var defaultMinDelay = 0.01
    @State var delayAfterPaste = 0.03
    @State var errors: [String] = []
    @State var hasPermissions = AXIsProcessTrusted()
    @State var holdCommand = false
    @State var holdControl = false
    @State var holdOption = false
    @State var holdShift = false
    @State var isPaused = false
    @State var linesToPaste: [String] = []
    @State var maxDelay = 0.03
    @State var minDelay = 0.01
    @State var scriptLines: [Substring] = []
    @State var scriptUrl: Optional<URL> = Optional.none
    @State var selectedAppName = "Not Selected"
    @State var selectedAppPid: Optional<pid_t> = Optional.none
    @State var statusArea = ""
    @State var statusLine = "Status: Ready"
    @State var statusLineForRun = ""
    
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
        "F1": (0x7A, ""),
        "F10": (0x6D, ""),
        "F11": (0x67, ""),
        "F12": (0x6F, ""),
        "F13": (0x69, ""),
        "F14": (0x6B, ""),
        "F15": (0x71, ""),
        "F16": (0x6A, ""),
        "F17": (0x40, ""),
        "F18": (0x4F, ""),
        "F19": (0x50, ""),
        "F2": (0x78, ""),
        "F20": (0x5A, ""),
        "F3": (0x63, ""),
        "F4": (0x76, ""),
        "F5": (0x60, ""),
        "F6": (0x61, ""),
        "F7": (0x62, ""),
        "F8": (0x64, ""),
        "F9": (0x65, ""),
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
    
    // note that this handles newline and newlines. there's
    // no difference in the behavior. It's just nicer to
    // be able to use either for the instructions. Would
    // be slightly better to split to 'newline' and 'newlines: NUMBER'
    // explicilty in the code. That's what the docs (will) show
    // even though it doesn't matter in the code
    func doNewline(parts: [String]) {
        if parts.count == 1 {
            charactersToType.append("\n")
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime() * 3) {
                typeCharacter()
            }
        } else if parts.count >= 2 {
            let newlineCount = Int(parts[1].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 1
            for _ in (0..<newlineCount) {
                charactersToType.append("\n")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime() * 3) {
                typeCharacter()
            }
        }
    }
    
    func doPaste(parts: [String]) {
        if parts.count > 1 {
            var charLoader: [String] = []
            var partsToLoad = parts
            partsToLoad.reverse()
            let _ = partsToLoad.popLast()
            partsToLoad.reverse()
            partsToLoad.forEach { thing in
                charLoader.append(thing)
            }
            let characterLine = charLoader.joined(separator: ":").trimmingCharacters(in: .whitespacesAndNewlines)
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(characterLine, forType: .string)
            let src = CGEventSource(stateID: .privateState)
            let doDown = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: true)
            let doUp = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: false)
            let flagList: [CGEventFlags] = [CGEventFlags.maskCommand]
            let flags: CGEventFlags = CGEventFlags.init(flagList)
            doDown?.flags = flags
            doUp?.flags = flags
            doDown?.postToPid(selectedAppPid!)
            doUp?.postToPid(selectedAppPid!)
        } else {
            addError(parts: parts, message: "Problem in doPaste")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delayAfterPaste) {
            processLine()
        }
    }
    
    func doPasteDown(parts: [String]) {
        if parts.count > 1 {
            var charLoader: [String] = []
            var partsToLoad = parts
            partsToLoad.reverse()
            let _ = partsToLoad.popLast()
            partsToLoad.reverse()
            partsToLoad.forEach { thing in
                charLoader.append(thing)
            }
            let characterLine = charLoader.joined(separator: ":").trimmingCharacters(in: .whitespacesAndNewlines)
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(characterLine, forType: .string)
            let src = CGEventSource(stateID: .privateState)
            let doDown = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: true)
            let doUp = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: false)
            let flagList: [CGEventFlags] = [CGEventFlags.maskCommand]
            let flags: CGEventFlags = CGEventFlags.init(flagList)
            doDown?.flags = flags
            doUp?.flags = flags
            doDown?.postToPid(selectedAppPid!)
            doUp?.postToPid(selectedAppPid!)
            DispatchQueue.main.asyncAfter(deadline: .now() + delayAfterPaste) {
                charactersToType.append(String("down-arrow"))
                typeCharacter()
            }
        } else {
            addError(parts: parts, message: "Problem in doPasteDown")
            processLine()
        }
    }
    
    func doPasteFile(parts: [String]) {
        if parts.count == 2 {
            do {
                let fileUrl = URL(string: "file://" + parts[1].trimmingCharacters(in: .whitespacesAndNewlines))
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
        } else {
            addError(parts: parts, message: "Issue in doPasteFile")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delayAfterPaste) {
            processLine()
        }
    }
    
    func doPasteFileLine() {
        if linesToPaste.count > 0 {
            var lineToPaste = linesToPaste.popLast()!
            lineToPaste.append("\n")
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(lineToPaste, forType: .string)
            let src = CGEventSource(stateID: .privateState)
            let doDown = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: true)
            let doUp = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: false)
            let flagList: [CGEventFlags] = [CGEventFlags.maskCommand]
            let flags: CGEventFlags = CGEventFlags.init(flagList)
            doDown?.flags = flags
            doUp?.flags = flags
            doDown?.postToPid(selectedAppPid!)
            doUp?.postToPid(selectedAppPid!)
            DispatchQueue.main.asyncAfter(deadline: .now() + delayAfterPaste) {
                doPasteFileLine()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + delayAfterPaste) {
                processLine()
            }
        }
    }
    
    func doPasteFileLineDown() {
        if linesToPaste.count > 0 {
            let lineToPaste = linesToPaste.popLast()!
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(lineToPaste, forType: .string)
            let src = CGEventSource(stateID: .privateState)
            let doDown = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: true)
            let doUp = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: false)
            let flagList: [CGEventFlags] = [CGEventFlags.maskCommand]
            let flags: CGEventFlags = CGEventFlags.init(flagList)
            doDown?.flags = flags
            doUp?.flags = flags
            doDown?.postToPid(selectedAppPid!)
            doUp?.postToPid(selectedAppPid!)
            DispatchQueue.main.asyncAfter(deadline: .now() + delayAfterPaste) {
                typeDownArrow()
                doPasteFileLineDown()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + delayAfterPaste) {
                processLine()
            }
        }
    }
    
    func doPasteFileLines(parts: [String]) {
        if parts.count == 2 {
            do {
                let fileUrl = URL(string: "file://" + parts[1].trimmingCharacters(in: .whitespacesAndNewlines))
                let contentToPaste = try String(contentsOf: fileUrl!, encoding: String.Encoding.utf8)
                linesToPaste = contentToPaste.split(separator: "\n", omittingEmptySubsequences: false).map{ String($0) }
                linesToPaste.reverse()
                doPasteFileLine()
            } catch{
                addError(parts: parts, message: "Could not copy file")
                DispatchQueue.main.asyncAfter(deadline: .now() + delayAfterPaste) {
                    processLine()
                }
            }
        } else {
            addError(parts: parts, message: "Problem in doPasteFile")
            DispatchQueue.main.asyncAfter(deadline: .now() + delayAfterPaste) {
                processLine()
            }
        }
    }
    
    func doPasteFileLinesDown(parts: [String]) {
        if parts.count == 2 {
            do {
                let fileUrl = URL(string: "file://" + parts[1].trimmingCharacters(in: .whitespacesAndNewlines))
                let contentToPaste = try String(contentsOf: fileUrl!, encoding: String.Encoding.utf8)
                linesToPaste = contentToPaste.split(separator: "\n", omittingEmptySubsequences: false).map{ String($0) }
                linesToPaste.reverse()
                doPasteFileLineDown()
            } catch{
                addError(parts: parts, message: "Could not copy file")
                DispatchQueue.main.asyncAfter(deadline: .now() + delayAfterPaste) {
                    processLine()
                }
            }
        } else {
            addError(parts: parts, message: "Problem in doPasteFile")
            DispatchQueue.main.asyncAfter(deadline: .now() + delayAfterPaste) {
                processLine()
            }
        }
    }
    
    func doPasteLine(parts: [String]) {
        if parts.count > 1 {
            var charLoader: [String] = []
            var partsToLoad = parts
            partsToLoad.reverse()
            let _ = partsToLoad.popLast()
            partsToLoad.reverse()
            partsToLoad.forEach { thing in
                charLoader.append(thing)
            }
            let characterLine = charLoader.joined(separator: ":").trimmingCharacters(in: .whitespacesAndNewlines)
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(characterLine, forType: .string)
            let src = CGEventSource(stateID: .privateState)
            let doDown = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: true)
            let doUp = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: false)
            let flagList: [CGEventFlags] = [CGEventFlags.maskCommand]
            let flags: CGEventFlags = CGEventFlags.init(flagList)
            doDown?.flags = flags
            doUp?.flags = flags
            doDown?.postToPid(selectedAppPid!)
            doUp?.postToPid(selectedAppPid!)
            DispatchQueue.main.asyncAfter(deadline: .now() + delayAfterPaste) {
                charactersToType.append(String("\n"))
                typeCharacter()
            }
        } else {
            addError(parts: parts, message: "Problem in doPasteDown")
            processLine()
        }
    }
    
    func doPause(parts: [String]) {
        if parts.count == 1 {
            isPaused = true
            statusLine = "Status: Paused. Press F2 to resume"
            statusLineForRun = "Paused. Press F2 to resume"
        } else {
            if debugging == false {
                if parts.count == 2 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + (Double(parts[1].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0.0)) {
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
        // TODO: lowercase the incoming letters so
        // they don't fail if someone types a capital.
        // Either that, or throw an error? TBD on that.
        // or, if they are capital, just do that? probably the best option
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
                            if trimmedPart.trimmingCharacters(in: .whitespacesAndNewlines) == "command" {
                                holdCommand = true
                            } else if trimmedPart.trimmingCharacters(in: .whitespacesAndNewlines) == "control" {
                                holdControl = true
                            } else if trimmedPart.trimmingCharacters(in: .whitespacesAndNewlines) == "option" {
                                holdOption = true
                            } else if trimmedPart.trimmingCharacters(in: .whitespacesAndNewlines) == "shift" {
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
            let repeatCount = Int32(truncating: NumberFormatter().number(from: parts[1].trimmingCharacters(in: .whitespacesAndNewlines))!)
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
                            if trimmedPart.trimmingCharacters(in: .whitespacesAndNewlines) == "command" {
                                holdCommand = true
                            } else if trimmedPart.trimmingCharacters(in: .whitespacesAndNewlines) == "control" {
                                holdControl = true
                            } else if trimmedPart.trimmingCharacters(in: .whitespacesAndNewlines) == "option" {
                                holdOption = true
                            } else if trimmedPart.trimmingCharacters(in: .whitespacesAndNewlines) == "shift" {
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
            minDelay = Double(parts[1].trimmingCharacters(in: .whitespacesAndNewlines)) ?? defaultMinDelay
            maxDelay = Double(parts[2].trimmingCharacters(in: .whitespacesAndNewlines)) ?? defaultMaxDelay
        } else if parts.count == 2 {
            minDelay = Double(parts[1].trimmingCharacters(in: .whitespacesAndNewlines)) ?? defaultMinDelay
            maxDelay = Double(parts[1].trimmingCharacters(in: .whitespacesAndNewlines)) ?? defaultMaxDelay
        } else {
            // TODO: Show Error message
        }
        processLine()
    }
    
    func doStop() {
        statusLine = "Status: Received 'stop' instruction. Process halted"
        statusLineForRun = "Received 'stop' instruction. Process halted"
    }
    
    func doTypeCharacters(parts: [String]) {
        if parts.count > 1 {
            var charLoader: [String] = []
            var partsToLoad = parts
            partsToLoad.reverse()
            let _ = partsToLoad.popLast()
            partsToLoad.reverse()
            partsToLoad.forEach { thing in
                charLoader.append(thing)
            }
            let characterLine = charLoader.joined(separator: ":").trimmingCharacters(in: .whitespacesAndNewlines)
            var charactersToLoad = characterLine.split(separator: "")
            charactersToLoad.reverse()
            for x in charactersToLoad {
                charactersToType.append(String(x))
            }
            typeCharacter()
        }
    }
    
    func doTypeDown(parts: [String]) {
        if parts.count > 1 {
            var charLoader: [String] = []
            var partsToLoad = parts
            partsToLoad.reverse()
            let _ = partsToLoad.popLast()
            partsToLoad.reverse()
            partsToLoad.forEach { thing in
                charLoader.append(thing)
            }
            let characterLine = charLoader.joined(separator: ":").trimmingCharacters(in: .whitespacesAndNewlines)
            var charactersToLoad = characterLine.split(separator: "")
            charactersToLoad.append("down-arrow")
            charactersToLoad.reverse()
            for x in charactersToLoad {
                charactersToType.append(String(x))
            }
            typeCharacter()
        }
    }
    
    func doTypeLine(parts: [String]) {
        if parts.count > 1 {
            var charLoader: [String] = []
            var partsToLoad = parts
            partsToLoad.reverse()
            let _ = partsToLoad.popLast()
            partsToLoad.reverse()
            partsToLoad.forEach { thing in
                charLoader.append(thing)
            }
            let characterLine = charLoader.joined(separator: ":").trimmingCharacters(in: .whitespacesAndNewlines)
            var charactersToLoad = characterLine.split(separator: "")
            charactersToLoad.append("\n")
            charactersToLoad.reverse()
            for x in charactersToLoad {
                charactersToType.append(String(x))
            }
            typeCharacter()
        }
    }
    
    func focusedAppPid() -> Optional<pid_t> {
        if let process = NSWorkspace.shared.frontmostApplication {
            return process.processIdentifier
        } else {
            return Optional.none
        }
    }
    
    func processLine() {
        holdCommand = false
        holdControl = false
        holdShift = false
        holdOption = false
        if focusedAppPid() != Optional(selectedAppPid!) {
            statusLine = "Status: Process halted becuase app lost focus"
            statusLineForRun = "Process halted becuase app lost focus"
        } else if captureLines == true {
            let line = scriptLines.popLast()
            if line?.trimmingCharacters(in: .whitespacesAndNewlines) == "end-lines" {
                captureLines = false
                linesToPaste.reverse()
                doPasteFileLine()
            } else {
                if let lineToAdd = line {
                    linesToPaste.append(String(lineToAdd))
                }
                processLine()
            }
        } else if captureLinesDown == true {
            let line = scriptLines.popLast()
            if line?.trimmingCharacters(in: .whitespacesAndNewlines) == "end-lines-down" {
                captureLinesDown = false
                linesToPaste.reverse()
                doPasteFileLineDown()
            } else {
                if let lineToAdd = line {
                    linesToPaste.append(String(lineToAdd))
                }
                processLine()
            }
        } else if scriptLines.count > 0 {
            let line = scriptLines.popLast()
            let parts_substrings = line?.split(separator: ":", omittingEmptySubsequences: false)
            var parts: [String] = []
            for part in parts_substrings! {
                parts.append(String(part))
            }
            let action = parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
            if action == "debug" {
                doDebug(parts: parts)
            } else if action == "down" {
                doDown(parts: parts)
            } else if action == "newline" {
                doNewline(parts: parts)
            } else if action == "newlines" {
                doNewline(parts: parts)
            } else if action == "paste" {
                doPaste(parts: parts)
            } else if action == "paste-down" {
                doPasteDown(parts: parts)
            } else if action == "paste-line" {
                doPasteLine(parts: parts)
            } else if action == "paste-file" {
                doPasteFile(parts: parts)
            } else if action == "paste-file-lines" {
                doPasteFileLines(parts: parts)
            } else if action == "paste-file-lines-down" {
                doPasteFileLinesDown(parts: parts)
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
            } else if action == "start-lines" {
                captureLines = true
                processLine()
            } else if action == "start-lines-down" {
                captureLinesDown = true
                processLine()
            } else if action == "stop" {
                doStop()
            } else if action == "type" {
                doTypeCharacters(parts: parts)
            } else if action == "type-down" {
                doTypeDown(parts: parts)
            } else if action == "type-line" {
                doTypeLine(parts: parts)
            } else {
                processLine()
            }
        } else {
            statusLine = "Status: Process complete"
            statusLineForRun = "Process complete"
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
            statusLine = "Status: Choose an Insturctions File first"
            statusLineForRun = "Choose an Insturctions File first"
        } else if selectedAppPid == Optional.none {
            statusLine = "Status: Choose an app first"
            statusLineForRun = "Choose an app first"
        } else if checkPermissions() == false {
            statusLine = "Status: Provide permissions then Run again"
            statusLineForRun = "Provide permissions then Run again"
        } else {
            statusLine = "Status: Running..."
            statusLineForRun = "Running..."
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
                scriptLines = scriptContents.split(separator: "\n", omittingEmptySubsequences: false)
                scriptLines.reverse()
                // wait a second after activation before running
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    processLine()
                }
            } catch{
                statusLine = "Status: ERROR: Could not open file"
                statusLineForRun = "ERROR: Could not open file"
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
    
    func typeDownArrow() {
        let src = CGEventSource(stateID: .privateState)
        let doDown = CGEvent(keyboardEventSource: src, virtualKey: 0x7D, keyDown: true)
        let doUp = CGEvent(keyboardEventSource: src, virtualKey: 0x7D, keyDown: false)
        doDown?.postToPid(selectedAppPid!)
        doUp?.postToPid(selectedAppPid!)
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
                    Button("Choose Instructions File") {
                        chooseScript()
                    }
                    Text(getUrlFileName()).frame(maxWidth: .infinity, alignment: .leading)
                }.padding()
                Divider()
                VStack {
                    Text("Select App").frame(maxWidth: .infinity, alignment: .leading)
                    List(runningApps(), selection: $selectedAppPid) {
                        Text($0.app.localizedName ?? "unknown name")
                    }
                }.padding()
                Divider()
                HStack {
                    Text(statusLineForRun)
                    Button("Run") {
                        runScript()
                    }
                }.frame(maxWidth: .infinity, alignment: .trailing).padding()
            }.frame(maxWidth: .infinity)
            Divider()
            VStack {
                TabView{
//                    StatusView(statusLine: statusLine, statusArea: statusArea).tabItem {Text("Status") }
                    DocsView().tabItem { Text("Docs") }
                    KeysView(pressCodes: pressCodes).tabItem { Text("Key Names") }
//                    ExamplesView().tabItem { Text("Examples") }
//                    Examples2View().tabItem { Text("Examples2") }
                }
                Spacer()
            }.padding()
        }
    }
}

#Preview {
    ContentView()
}
