import Foundation

// MARK: - ViewModel

final class PostDetailsViewModel {
    
    enum State {
        case loading
        case foundPost
    }
    
    // MARK: - Properties
    
    private let networkService = NetworkService()
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }()

    var changeUIForState: ((State) -> Void)?
    var postModel: PostDetailsModel

    init(postModel: PostDetailsModel) {
        self.postModel = postModel
    }

    // MARK: - Public methods
    
    func loadPost(id: Int) {
        changeUIForState?(.loading)
        let detailPostURL = "posts/\(id).json"
        
        guard let url = URL(string: URLConstants.baseURL + detailPostURL) else { return }
        
        networkService.executeRequest(url: url, responseType: DetailPostRequestResponse.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let result):
                postModel.imageURL = result.post.imageURL
                postModel.text = result.post.text
                changeUIForState?(.foundPost)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }

    func getPostDate(from timestamp: Int) -> String {
        let timeInterval = TimeInterval(timestamp)
        let dateFromTimestamp = Date(timeIntervalSince1970: timeInterval)
        let stringDate = Self.formatter.string(from: dateFromTimestamp)
        return stringDate
    }
}
