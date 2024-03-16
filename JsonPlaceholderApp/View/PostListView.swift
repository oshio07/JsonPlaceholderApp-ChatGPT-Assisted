import SwiftUI

struct PostListView: View {
    
    @StateObject private var viewModel = PostListViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView().padding()
                    Spacer()
                } else {
                    List(viewModel.posts.filter {
                        viewModel.searchText.isEmpty ? true : $0.title.localizedStandardContains(viewModel.searchText)
                    }) { post in
                        NavigationLink(destination: PostDetailView(viewModel: PostDetailViewModel(post: post))) {
                            PostRowView(post: post)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .searchable(text: $viewModel.searchText)
                }
            }
            .navigationBarTitle("Posts")

            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(title: Text("Error"), message: Text("Failed to get posts."), dismissButton: .default(Text("OK")))
            }
        }
        .onAppear {
            Task {
                await viewModel.getPosts()
            }
        }
    }
}

struct PostRowView: View {
    
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
                .font(.headline)
            Text(post.body)
                .font(.subheadline)
                .lineLimit(2)
                .foregroundColor(.secondary)
        }
    }
}

struct PostListView_MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
