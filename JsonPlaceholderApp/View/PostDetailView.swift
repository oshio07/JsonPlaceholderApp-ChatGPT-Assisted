import SwiftUI

struct PostDetailView: View {
    
    @StateObject var viewModel: PostDetailViewModel
    
    var body: some View {
        
        ScrollView {
            if viewModel.isLoading {
                ProgressView().padding()
                Spacer()
            } else {
                VStack(alignment: .leading) {
                    
                    Text(viewModel.post.title)
                        .font(.title)
                        .fontWeight(.black)
                    
                    HStack(alignment: .bottom) {
                        
                        if let user = viewModel.user {
                            NavigationLink(destination: UserDetailView(viewModel: UserDetailViewModel(user: user))) {
                                Text(user.name)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.toggleFavoritePost()
                        }) {
                            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .font(.system(size: 32))
                                .padding(.horizontal)
                        }
                    }
                    Divider()
                    
                    Text(viewModel.post.body)
                    Divider()
                    
                    Text("Comments").font(.title2).fontWeight(.black)
                    
                    if viewModel.comments.isEmpty {
                        Text("No comments.")
                            .foregroundColor(.secondary)
                            .padding()
                        Spacer()
                    } else {
                        ForEach(viewModel.displayedComments) { comment in
                            CommentRowView(comment: comment)
                        }
                        if viewModel.comments.count > 1 && viewModel.displayedComments.count == 1 {
                            Button(action: {
                                viewModel.displayedComments = viewModel.comments
                            }) {
                                Text("Show all")
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text("Error"), message: Text("Failed to get post detail."), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            Task {
                await viewModel.getPostDetail(postId: viewModel.post.id)
                await viewModel.getPostComments(postId: viewModel.post.id)
            }
        }
    }
}

struct CommentRowView: View {
    
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(comment.name)
                .font(.headline)
            Text(comment.body)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let post = Post(id: 1,
                        userId: 1,
                        title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                        body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        PostDetailView(viewModel: .init(post: post))
    }
}
