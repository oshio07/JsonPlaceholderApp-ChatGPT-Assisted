import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    
    struct Address: Codable {
        let city: String
    }
}
