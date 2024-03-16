import Foundation

struct Comment: Codable, Identifiable {
    let id: Int
    let postId: Int
    let name: String
    let body: String
}
