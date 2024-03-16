import SwiftUI

@MainActor
class PostDetailViewModel: ObservableObject {
    
    @Published var post: Post
    @Published var user: User?
    @Published var isLoading = false
    @Published var isFavorite = false
    @Published var comments: [Comment] = []
    @Published var displayedComments: [Comment] = []
    @Published var showErrorAlert = false
    
    init(post: Post) {
        self.post = post
    }
    
    func getPostComments(postId: Int) async {
        isLoading = true
        do {
            comments = try await APIService.shared.getComments(postId: postId)
            displayedComments = Array(comments.prefix(1))
        } catch {
            showErrorAlert = true
        }
        isLoading = false
    }
    
    func getPostDetail(postId: Int) async {
        isLoading = true
        do {
            post = try await APIService.shared.getPost(postId: postId)
            user = try await APIService.shared.getUser(userId: post.userId)
            isFavorite = isPostFavorite()
        } catch {
            showErrorAlert = true
        }
        isLoading = false        
    }
    
    func toggleFavoritePost() {
        if isPostFavorite() {
            isFavorite = false
            FavoritePostsManager.shared.removeFavoritePost(post: post)
        } else {
            isFavorite = true
            FavoritePostsManager.shared.addFavoritePost(post: post)
        }
    }
    
    private func isPostFavorite() -> Bool {
        return FavoritePostsManager.shared.getFavoritePosts().contains(where: { $0.id == post.id })
    }
}
