import Foundation

public struct CleanReport: Identifiable, Codable {
    public let id: UUID
    public let timestamp: Date
    public let items: [CleanItem]
    public let totalSize: Int64
    
    public init(items: [CleanItem]) {
        self.id = UUID()
        self.timestamp = Date()
        self.items = items
        self.totalSize = items.reduce(0) { $0 + $1.size }
    }
    
    public var formattedTotalSize: String {
        return ByteCountFormatter.string(fromByteCount: totalSize, countStyle: .file)
    }
}

public struct CleanItem: Identifiable, Codable {
    public let id: UUID
    public let name: String
    public let path: String
    public let size: Int64
    public let category: CleanCategory
    public var isSelected: Bool
    
    public init(name: String, path: String, size: Int64, category: CleanCategory, isSelected: Bool = true) {
        self.id = UUID()
        self.name = name
        self.path = path
        self.size = size
        self.category = category
        self.isSelected = isSelected
    }
    
    public var formattedSize: String {
        return ByteCountFormatter.string(fromByteCount: size, countStyle: .file)
    }
}

public enum CleanCategory: String, CaseIterable, Codable {
    case systemCache = "System Cache"
    case userLogs = "User Logs"
    case trash = "Trash"
    case xcodeDerivedData = "Xcode DerivedData"
    case browserCache = "Browser Cache"
    case mailAttachments = "Mail Attachments"
    case other = "Other"
    
    public var icon: String {
        switch self {
        case .systemCache: return "memorychip"
        case .userLogs: return "doc.text.magnifyingglass"
        case .trash: return "trash"
        case .xcodeDerivedData: return "hammer"
        case .browserCache: return "globe"
        case .mailAttachments: return "envelope"
        case .other: return "folder"
        }
    }
}
