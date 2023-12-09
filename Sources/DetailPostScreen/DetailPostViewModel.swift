import Foundation

final class DetailPostViewModel {

    enum State {
        case loading
        case foundPost
    }

    var changeUIForState: ((State) -> Void)?
    var detailPost: DetailPostModel?
    private var state: State = .loading
    private let networkService = NetworkService()
    var postTitle = ""
    var postText = ""
    var imageURL = ""

    func changeState(for newState: State) {
        self.state = newState
        changeUIForState?(newState)
    }

    func loadPost(id: Int) {
        changeUIForState?(.loading)
        networkService.fetchPost(with: id) { [weak self] response in
            guard let self else { return }
            self.detailPost = response
            if let detailPost = self.detailPost {
                postText = detailPost.text
                imageURL = detailPost.imageURL
                changeUIForState?(.foundPost)
            }
        }
    }
}
