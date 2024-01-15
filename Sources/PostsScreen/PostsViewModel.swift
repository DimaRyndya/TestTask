import UIKit

protocol PostsViewModelDeledate: AnyObject {
    func reloadUI()
}

enum PostsSortType {
    case date, likes
}

final class PostsViewModel {

    var posts: [PostModel] = []

    weak var delegate: PostsViewModelDeledate?

    private let networkService = NetworkService()

    func viewDidLoad() {
        networkService.fetchPosts { [weak self] response in
            guard let self else { return }
            self.posts = response
            self.delegate?.reloadUI()
        }
    }

    func filterButtonTapped(sortType: PostsSortType, isAscending: Bool) {
        switch sortType {
        case .date:
            sortByDate(isAscending: isAscending)
        case .likes:
            sortByLikes(isAscending: isAscending)
        }
    }

    private func sortByDate(isAscending: Bool) {
        if isAscending {
            posts.sort { $0.timestamp > $1.timestamp }
        } else {
            posts.sort { $0.timestamp < $1.timestamp }
        }

        delegate?.reloadUI()
    }

    private func sortByLikes(isAscending: Bool) {
        if isAscending {
            posts.sort { $0.likes > $1.likes }
        } else {
            posts.sort { $0.likes < $1.likes }
        }

        delegate?.reloadUI()
    }
}
