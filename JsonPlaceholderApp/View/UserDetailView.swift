import SwiftUI

struct UserDetailView: View {
    
    @StateObject var viewModel: UserDetailViewModel
    
    var body: some View {
        
        Group {
            
            if viewModel.isLoading {
                ProgressView().padding()
                Spacer()
            } else {
                List {
                    VStack(alignment: .leading) {
                        Text(viewModel.user.name)
                            .font(.title)
                            .fontWeight(.black)
                        Text("@" + viewModel.user.username)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(viewModel.user.email)
                            .padding(.top, 4)
                        Text(viewModel.user.phone)
                        HStack {
                            Text(Image(systemName: "mappin.circle"))
                            Text(viewModel.user.address.city)
                        }
                        .padding(.top, 4)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                    .listRowSeparator(.hidden)
                    
                    Text("Posts")
                        .font(.title2)
                        .fontWeight(.black)
                    
                    if viewModel.posts.isEmpty {
                        Text("No posts.")
                            .foregroundColor(.secondary)
                            .padding()
                        Spacer()
                    } else {
                        ForEach(viewModel.posts) { post in
                            NavigationLink(destination: PostDetailView(viewModel: PostDetailViewModel(post: post))) {
                                PostRowView(post: post)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            Task {
                await viewModel.getUser(userId: viewModel.user.id)
                await viewModel.getUserPosts(userId: viewModel.user.id)
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: 1,
                        name: "Leanne Graham",
                        username: "Bret",
                        email: "Sincere@april.biz",
                        address: .init(city: "Gwenborough"),
                        phone: "1-770-736-8031 x56442")
        UserDetailView(viewModel: .init(user: user))
    }
}
