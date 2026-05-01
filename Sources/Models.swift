import Foundation

enum Platform: String, CaseIterable, Identifiable, Codable {
    case snapchat = "Snapchat"
    case youtube = "YouTube"
    case linkedIn = "LinkedIn"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .snapchat: return "👻"
        case .youtube: return "▶️"
        case .linkedIn: return "in"
        }
    }
}

struct ContentItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var platform: Platform
    var status: Status
    var publishDate: Date
    var notes: String

    enum Status: String, CaseIterable, Identifiable, Codable {
        case idea = "Idea"
        case drafting = "Drafting"
        case scheduled = "Scheduled"
        case published = "Published"

        var id: String { rawValue }
    }
}
