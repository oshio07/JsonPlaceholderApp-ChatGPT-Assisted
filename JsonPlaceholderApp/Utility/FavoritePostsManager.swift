import Foundation

class FavoritePostsManager {
    
    static let shared = FavoritePostsManager()
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let key = "favoritePosts"

    func getFavoritePosts() -> [Post] {
        if let data = userDefaults.data(forKey: key),
           let favoritePosts = try? JSONDecoder().decode([Post].self, from: data) {
            return favoritePosts
        }
        return []
    }
    
    func addFavoritePost(post: Post) {
        var favoritePosts = getFavoritePosts()
        if !favoritePosts.contains(where: { $0.id == post.id }) {
            favoritePosts.append(post)
            saveFavoritePosts(posts: favoritePosts)
        }
    }
    
    func removeFavoritePost(post: Post) {
        var favoritePosts = getFavoritePosts()
        if let index = favoritePosts.firstIndex(where: { $0.id == post.id }) {
            favoritePosts.remove(at: index)
            saveFavoritePosts(posts: favoritePosts)
        }
    }
    
    private func saveFavoritePosts(posts: [Post]) {
        if let data = try? JSONEncoder().encode(posts) {
            userDefaults.set(data, forKey: key)
        }
    }
}
