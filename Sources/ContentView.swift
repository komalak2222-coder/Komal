import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var contentStore: ContentStore
    @State private var showComposer = false

    var body: some View {
        NavigationSplitView {
            List(selection: $contentStore.selectedPlatform) {
                Text("All Platforms").tag(Optional<Platform>.none)
                ForEach(Platform.allCases) { platform in
                    Text("\(platform.icon) \(platform.rawValue)")
                        .tag(Optional(platform))
                }
            }
            .navigationTitle("OG Manager")
        } content: {
            VStack(spacing: 0) {
                HStack {
                    Text("Content Queue")
                        .font(.title2.bold())
                    Spacer()
                    Button("New Item") {
                        showComposer = true
                    }
                    .keyboardShortcut("n", modifiers: [.command])
                }
                .padding()

                List {
                    ForEach(contentStore.filteredItems) { item in
                        ContentRow(item: item)
                    }
                    .onDelete(perform: contentStore.remove)
                }
            }
        } detail: {
            VStack(alignment: .leading, spacing: 16) {
                Text("Plan once. Publish everywhere.")
                    .font(.largeTitle.bold())
                Text("Track your Snapchat stories, YouTube videos, and LinkedIn posts in one place.")
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(24)
        }
        .sheet(isPresented: $showComposer) {
            ComposerView()
                .environmentObject(contentStore)
        }
    }
}

private struct ContentRow: View {
    let item: ContentItem

    var body: some View {
        HStack(spacing: 14) {
            Text(item.platform.icon)
                .font(.title3)
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                Text(item.status.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(item.publishDate, style: .date)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

private struct ComposerView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var contentStore: ContentStore

    @State private var title = ""
    @State private var platform: Platform = .youtube
    @State private var status: ContentItem.Status = .idea
    @State private var publishDate = Date()
    @State private var notes = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                Picker("Platform", selection: $platform) {
                    ForEach(Platform.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                Picker("Status", selection: $status) {
                    ForEach(ContentItem.Status.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                DatePicker("Publish Date", selection: $publishDate)
                TextField("Notes", text: $notes, axis: .vertical)
                    .lineLimit(3...6)
            }
            .navigationTitle("New Content")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let item = ContentItem(
                            id: UUID(),
                            title: title,
                            platform: platform,
                            status: status,
                            publishDate: publishDate,
                            notes: notes
                        )
                        contentStore.add(item)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        .frame(minWidth: 460, minHeight: 420)
    }
}
