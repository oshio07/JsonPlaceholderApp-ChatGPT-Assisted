# JsonPlaceholderApp

A Client App for [JSONPlaceholder](https://jsonplaceholder.typicode.com).

```markdown
ContentView
    └─> PostListView ──> PostDetailView <─┐
    │                        ^    │       │
    │                        │    v       │
    └─> UserListView ──> UserDetailView   │
    │                                     │
    │                                     │
    └─> FavoritePostsView ────────────────┘
```

| PostListView | UserListView | FavoritePostsView |
| :-: | :-: | :-: |
| ![](https://github.com/skw398/JsonPlaceholderApp/blob/main/.github/PostListView.png) | ![](https://github.com/skw398/JsonPlaceholderApp/blob/main/.github/UserListView.png) | ![](https://github.com/skw398/JsonPlaceholderApp/blob/main/.github/FavoritePostsView.png) |
| PostDetailView | UserDetailView |
| ![](https://github.com/skw398/JsonPlaceholderApp/blob/main/.github/PostDetailView.png) | ![](https://github.com/skw398/JsonPlaceholderApp/blob/main/.github/UserDetailView.png) |
