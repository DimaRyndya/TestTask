import Foundation

final class DetailPostViewModel {
    
    enum State {
        case loading
        case foundPost
    }
    
    private var state: State = .loading
    private let networkService = NetworkService()
    var postTitle = ""
    var postText = ""
    var imageURL = ""
    var postLikes = ""
    var timestamp = 0
    var changeUIForState: ((State) -> Void)?
    var detailPost: DetailPostModel?
    
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
    
    func getPostdate() -> String {
        let formatter = DateFormatter()
        let timeInterval = TimeInterval(timestamp)
        let dateFromTimestamp = Date(timeIntervalSince1970: timeInterval)
        
        formatter.dateFormat = "dd MMMM yyyy"
        
        let stringDate = formatter.string(from: dateFromTimestamp)
        return stringDate
    }
}
