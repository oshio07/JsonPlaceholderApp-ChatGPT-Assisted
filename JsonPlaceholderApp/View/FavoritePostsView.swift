import SwiftUI

struct FavoritePostsView: View {
    
    @StateObject private var viewModel = FavoritePostsViewModel()
    
    var body: some View {
        
        NavigationView {
            Group {
                if viewModel.favoritePosts.isEmpty {
                    Text("No favorite posts.")
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                } else {
                    List(viewModel.favoritePosts) { post in
                        NavigationLink(
                            destination: PostDetailView(viewModel: PostDetailViewModel(post: post))
                        ) {
                            PostRowView(post: post)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("Favorites")
        }
        .refreshable {
            viewModel.getFavoritePosts()
        }
        .onAppear {
            viewModel.getFavoritePosts()
        }
    }
}

struct FavoritePostsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePostsView()
    }
}
