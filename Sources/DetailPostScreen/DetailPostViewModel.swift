import Foundation

final class DetailPostViewModel {

    enum State {
        case loading
        case foundPost
    }

    var state: State = .loading
    private let networkService = NetworkService()

}
