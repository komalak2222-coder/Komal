import Foundation
import Combine

final class ContentStore: ObservableObject {
    @Published var items: [ContentItem] = []
    @Published var selectedPlatform: Platform? = nil

    var filteredItems: [ContentItem] {
        guard let selectedPlatform else { return items.sorted { $0.publishDate > $1.publishDate } }
        return items.filter { $0.platform == selectedPlatform }.sorted { $0.publishDate > $1.publishDate }
    }

    init() {
        seedData()
    }

    func add(_ item: ContentItem) {
        items.append(item)
    }

    func remove(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    private func seedData() {
        items = [
            ContentItem(id: UUID(), title: "Product Tip: 30s Snapchat Story", platform: .snapchat, status: .idea, publishDate: .now.addingTimeInterval(60 * 60 * 24), notes: "Hook in first 2 seconds."),
            ContentItem(id: UUID(), title: "YouTube Shorts: Behind the scenes", platform: .youtube, status: .drafting, publishDate: .now.addingTimeInterval(60 * 60 * 48), notes: "Add captions and thumbnail."),
            ContentItem(id: UUID(), title: "LinkedIn Post: Weekly growth recap", platform: .linkedIn, status: .scheduled, publishDate: .now.addingTimeInterval(60 * 60 * 72), notes: "Include one chart and CTA.")
        ]
    }
}
