import UIKit

protocol PostsViewModelDeledate: AnyObject {
    func reloadUI()
}

final class PostsViewModel {

    var posts: [PostModel] = []
    var isAscending = true

    private let networkService = NetworkService()

    weak var delegate: PostsViewModelDeledate?

    func viewDidLoad() {
        networkService.fetchPosts { [weak self] response in
            guard let self else { return }
            self.posts = response
            self.delegate?.reloadUI()
        }
    }

    func sortByDateTapped() {
        isAscending.toggle()

        if isAscending {
            posts.sort { $0.timestamp < $1.timestamp }
        } else {
            posts.sort { $0.timestamp > $1.timestamp }
        }

        delegate?.reloadUI()
    }

    func sortByLikesTapped() {
        isAscending.toggle()

        if isAscending {
            posts.sort { $0.likes < $1.likes }
        } else {
            posts.sort { $0.likes > $1.likes }
        }

        delegate?.reloadUI()
    }
}
