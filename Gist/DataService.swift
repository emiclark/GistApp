import Foundation

class DataService {
  static let shared = DataService()
  
  fileprivate let baseURLString = "https://api.github.com"
  
  func fetchGists(completion: @escaping (Result<Any, Error>) -> Void) {
    let componentURL = createURLComponents(path: "/gists/public")
    guard let validURL = componentURL.url
    else {
      print(">> url failed")
      return
    }
    
    print(">> url: \(validURL)")
    
    URLSession.shared.dataTask(with: URLRequest(url: validURL)) { (data, response, error) in
      if let response = response as? HTTPURLResponse {
        print("response: \(response.statusCode)")
      }
      
      guard let validData = data, error == nil
      else {
        completion(.failure(error!))
        return
      }

      do {
        let json = try JSONSerialization.jsonObject(with: validData, options: [])
        print(json)
        completion(.success(json))
      } catch let error {
        print(error)
      }
      
    }.resume()
  }
  
  func createURLComponents(path: String) -> URLComponents {
    var componentURL = URLComponents()
    componentURL.scheme = "https"
    componentURL.host = "api.github.com"
    componentURL.path = path
    return componentURL
  }
}
