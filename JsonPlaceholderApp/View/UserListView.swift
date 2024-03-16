import SwiftUI

struct UserListView: View {
    
    @StateObject private var viewModel = UserListViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            if viewModel.isLoading {
                ProgressView().padding()
                Spacer()
            } else {
                List(viewModel.users) { user in
                    NavigationLink(destination: UserDetailView(viewModel: UserDetailViewModel(user: user))) {
                        Text(user.name)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Users")
            }
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text("Error"), message: Text("Failed to get user list."), dismissButton: .default(Text("OK")))
        }
        .task {
            await viewModel.getUserList()
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
