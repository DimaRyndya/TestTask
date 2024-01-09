import UIKit

protocol PostsViewModelDeledate: AnyObject {
    func reloadUI()
}

final class PostsViewModel {
    var posts: [PostModel] = []
//    var detailPost: DetailPostModel?
    private let networkService = NetworkService()

    weak var delegate: PostsViewModelDeledate?

    var isAscending = true

    func viewDidLoad() {
        networkService.fetchPosts { [weak self] response in
            guard let self else { return }
            self.posts = response
            self.delegate?.reloadUI()
        }
    }

    func sortByDateTapped() {
        isAscending.toggle()

        posts.sort { (firstItem, secondItem) in
            let firstDate = firstItem.timestamp
            let secondDate = secondItem.timestamp

            if isAscending {
                return firstDate < secondDate
            } else {
                return firstDate > secondDate
            }
        }
        delegate?.reloadUI()
    }

    func sortByLikesTapped() {
        isAscending.toggle()

        posts.sort { (firstItem, secondItem) in
            let firstPostLikes = firstItem.likes
            let secondPostLikes = secondItem.likes

            if isAscending {
                return firstPostLikes < secondPostLikes
            } else {
                return firstPostLikes > secondPostLikes
            }
        }
        delegate?.reloadUI()
    }

//    func loadPost(id: Int) {
//        networkService.fetchPost(with: id) { [weak self] response in
//            guard let self else { return }
//            self.detailPost = response
//        }
//    }
}
