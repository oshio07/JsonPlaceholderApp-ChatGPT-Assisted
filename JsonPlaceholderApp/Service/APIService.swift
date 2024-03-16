import Foundation

class APIService {

    enum APIError: Error {
        case invalidURL
        case invalidResponse
        case decodingError
    }

    static let shared = APIService()
    private init() {}

    private let baseURL = "https://jsonplaceholder.typicode.com"

    private func makeRequest(path: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"

        return request
    }

    private func handleResponse<T: Decodable>(_ data: Data?, _ response: URLResponse?) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }

        guard let data = data else {
            throw APIError.decodingError
        }

        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw APIError.decodingError
        }
    }

    func getPosts() async throws -> [Post] {
        let request = try makeRequest(path: "/posts")
        let (data, response) = try await URLSession.shared.data(for: request)
        return try handleResponse(data, response) as [Post]
    }

    func getPost(postId: Int) async throws -> Post {
        let request = try makeRequest(path: "/posts/\(postId)")
        let (data, response) = try await URLSession.shared.data(for: request)
        return try handleResponse(data, response) as Post
    }

    func getUsers() async throws -> [User] {
        let request = try makeRequest(path: "/users")
        let (data, response) = try await URLSession.shared.data(for: request)
        return try handleResponse(data, response) as [User]
    }

    func getUser(userId: Int) async throws -> User {
        let request = try makeRequest(path: "/users/\(userId)")
        let (data, response) = try await URLSession.shared.data(for: request)
        return try handleResponse(data, response) as User
    }

    func getComments(postId: Int) async throws -> [Comment] {
        let request = try makeRequest(path: "/comments?postId=\(postId)")
        let (data, response) = try await URLSession.shared.data(for: request)
        return try handleResponse(data, response) as [Comment]
    }

    func getUserPosts(userId: Int) async throws -> [Post] {
        let request = try makeRequest(path: "/posts?userId=\(userId)")
        let (data, response) = try await URLSession.shared.data(for: request)
        return try handleResponse(data, response) as [Post]
    }
}
