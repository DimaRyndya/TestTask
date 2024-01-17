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
            sortByDate(isAscending: isAscending)
        case .likes:
            sortByLikes(isAscending: isAscending)
        }
    }
    
    // MARK: - Private methods
    
    private func sortByDate(isAscending: Bool) {
        if isAscending {
            posts.sort { $0.timestamp > $1.timestamp }
        } else {
            posts.sort { $0.timestamp < $1.timestamp }
        }
        
        output?.reloadUI()
    }
    
    private func sortByLikes(isAscending: Bool) {
        if isAscending {
            posts.sort { $0.likes > $1.likes }
        } else {
            posts.sort { $0.likes < $1.likes }
        }
        
        output?.reloadUI()
    }
}
