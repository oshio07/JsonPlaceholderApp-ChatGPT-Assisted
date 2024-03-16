import Foundation

@MainActor
class UserDetailViewModel: ObservableObject {
    
    @Published var user: User
    @Published var posts = [Post]()
    @Published var isLoading = false
    @Published var showErrorAlert = false
    
    init(user: User) {
        self.user = user
    }
    
    func getUser(userId: Int) async {
        isLoading = true
        do {
            user = try await APIService.shared.getUser(userId: userId)
        } catch {
            showErrorAlert = true
        }
        isLoading = false
    }
    
    func getUserPosts(userId: Int) async {
        isLoading = true
        do {
            posts = try await APIService.shared.getUserPosts(userId: userId)
        } catch {
            showErrorAlert = true
        }
        isLoading = false
    }
}
