import SwiftUI

@MainActor
class FavoritePostsViewModel: ObservableObject {
    
    @Published var favoritePosts: [Post] = []
    
    func getFavoritePosts() {
        favoritePosts = FavoritePostsManager.shared.getFavoritePosts()
    }
    
    func removeFavoritePost(post: Post) {
        FavoritePostsManager.shared.removeFavoritePost(post: post)
        getFavoritePosts()
    }
}
