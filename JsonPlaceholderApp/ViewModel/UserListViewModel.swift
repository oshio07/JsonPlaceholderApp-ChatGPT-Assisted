import SwiftUI

@MainActor
class UserListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var showErrorAlert = false
    
    func getUserList() async {
        isLoading = true
        do {
            users = try await APIService.shared.getUsers()
        } catch {
            showErrorAlert = true
        }
        isLoading = false
    }
}
