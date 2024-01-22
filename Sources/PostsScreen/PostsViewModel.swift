import UIKit

enum URLConstants {
    static let baseURL = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/"
    static let postsURL = "main.json"
}

enum PostsSortType {
    case date, likes
}

// MARK: - Protocols

protocol PostsViewModelInput: AnyObject {
    func viewDidLoad()
}

protocol PostsViewModelOutput: AnyObject {
    func reloadUI()
}

// MARK: - ViewModel

final class PostsViewModel: PostsViewModelInput {
    
    // MARK: - Properties
    
    var posts: [PostModel] = []
    
    weak var output: PostsViewModelOutput?
    
    private let networkService = NetworkService()
    
    // MARK: - Public methods
    
    func fetchPosts() {
        guard let url = URL(string: URLConstants.baseURL + URLConstants.postsURL) else { return }
        networkService.executeRequest(url: url, responseType: PostsRequestResponse.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let result):
                self.posts = result.posts
                output?.reloadUI()
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func viewDidLoad() {
        fetchPosts()
    }
    
    func filterButtonTapped(sortType: PostsSortType, isAscending: Bool) {
        switch sortType {
        case .date:
            posts.sort { ($0.timestamp > $1.timestamp) == isAscending }
            output?.reloadUI()
        case .likes:
            posts.sort { ($0.likes > $1.likes) == isAscending }
            output?.reloadUI()
        }
    }
}
