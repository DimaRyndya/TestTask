import UIKit

protocol PostsViewModelDeledate: AnyObject {
    func reloadUI()
}

final class PostsViewModel {
    var posts: [PostModel] = []
//    var detailPost: DetailPostModel?
    private let networkService = NetworkService()

    weak var delegate: PostsViewModelDeledate?

    func loadPosts() {
        networkService.fetchPosts { [weak self] response in
            guard let self else { return }
            self.posts = response
            self.delegate?.reloadUI()
        }
    }

//    func loadPost(id: Int) {
//        networkService.fetchPost(with: id) { [weak self] response in
//            guard let self else { return }
//            self.detailPost = response
//        }
//    }
}
