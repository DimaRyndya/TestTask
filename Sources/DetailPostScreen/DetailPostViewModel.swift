import Foundation

final class DetailPostViewModel {
    
    enum State {
        case loading
        case foundPost
    }
    
    // MARK: - Properties
    
    private var state: State = .loading
    private let networkService = NetworkService()
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }()
    
    var postTitle = ""
    var postText = ""
    var imageURL = ""
    var postLikes = ""
    var timestamp = 0
    var changeUIForState: ((State) -> Void)?
    var detailPost: DetailPostModel?
    
    // MARK: - Public methods
    
    func changeState(for newState: State) {
        self.state = newState
        changeUIForState?(newState)
    }
    
    func loadPost(id: Int) {
        changeUIForState?(.loading)
        let detailPostURL = "posts/\(id).json"
        
        guard let url = URL(string: URLConstants.baseURL + detailPostURL) else { return }
        
        networkService.executeRequest(url: url, responseType: DetailPostRequestResponse.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let result):
                self.detailPost = result.post
                if let detailPost = self.detailPost {
                    postText = detailPost.text
                    imageURL = detailPost.imageURL
                    changeUIForState?(.foundPost)
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func getPostDate() -> String {
        let timeInterval = TimeInterval(timestamp)
        let dateFromTimestamp = Date(timeIntervalSince1970: timeInterval)
        let stringDate = Self.formatter.string(from: dateFromTimestamp)
        return stringDate
    }
}
