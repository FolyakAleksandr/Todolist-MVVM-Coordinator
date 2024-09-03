import Alamofire

final class NetworkManager {
    static let instance = NetworkManager(); private init() {}

    enum Constant {
        static let url = "https://dummyjson.com/todos"
    }

    func getTodos(completion: @escaping (Result<[DataItem], Error>) -> Void) {
        AF.request(Constant.url).responseDecodable(of: ResponseData.self) { response in
            switch response.result {
            case .success(let responseData): completion(.success(responseData.todos))
            case .failure(let failure): completion(.failure(failure))
            }
        }
    }
}
