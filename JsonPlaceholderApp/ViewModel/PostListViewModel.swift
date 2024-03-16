import SwiftUI

@MainActor
class PostListViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var showErrorAlert = false
    @Published var searchText = ""
    
    func getPosts() async {
        isLoading = true
        do {
            posts = try await APIService.shared.getPosts()
        } catch {
            showErrorAlert = true
        }
        isLoading = false
    }
}
