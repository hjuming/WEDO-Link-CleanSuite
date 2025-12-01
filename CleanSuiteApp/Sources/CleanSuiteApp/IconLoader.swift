import SwiftUI
import AppKit

class IconLoader {
    static func load(_ name: String) -> NSImage {
        // Try to load from bundle resources first
        if let path = Bundle.module.path(forResource: name, ofType: nil),
           let image = NSImage(contentsOfFile: path) {
            return image
        }
        
        // Fallback to absolute path (dev mode)
        let devPath = "/Users/MING/.gemini/antigravity/playground/silent-opportunity/WedoLinkCleanSuite/assets/icons/\(name)"
        if let image = NSImage(contentsOfFile: devPath) {
            return image
        }
        
        // Fallback to system icon
        return NSImage(systemSymbolName: "gear", accessibilityDescription: nil) ?? NSImage()
    }
}
