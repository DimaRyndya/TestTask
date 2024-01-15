import Alamofire

final class NetworkService {
    
    let baseURL = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/"
    let postsURL = "main.json"

    func fetchPosts(completion: @escaping ([PostModel]) -> ()) {
        AF.request(baseURL + postsURL).responseDecodable(of: PostsRequestResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(result.posts)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }

    func fetchPost(with postID: Int, completion: @escaping (DetailPostModel) -> ()) {
        let detailPostURL = "posts/\(postID).json"
        AF.request(baseURL + detailPostURL).responseDecodable(of: DetailPostRequestResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(result.post)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
