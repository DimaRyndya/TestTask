import Foundation

final class ArticleDetailViewModel {

    enum State {
        case loading
        case foundPost
    }

    var state: State = .loading

}
