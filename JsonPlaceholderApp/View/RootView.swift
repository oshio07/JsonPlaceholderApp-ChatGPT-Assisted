import SwiftUI

struct RootView: View {
    
    var body: some View {
        TabView {
            PostListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Posts")
                }
            
            UserListView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Users")
                }
            
            FavoritePostsView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
