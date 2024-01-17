import Alamofire

final class NetworkService {
    
    // MARK: - Public methods
    
    func executeRequest<T>(url: URL, responseType: T.Type, completion: @escaping (AFDataResponse<T>) -> Void) where T: Decodable {
        AF.request(url).responseDecodable(of: responseType, completionHandler: completion)
    }
}
