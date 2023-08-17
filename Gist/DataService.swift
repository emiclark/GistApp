import Foundation

class DataService {
  static let shared = DataService()
  
  fileprivate let baseURLString = "https://api.github.com"
  
  func fetchGists() {
    let url = createURLComponents(path: "/gists")
    print(">> url: \(url)")
  }
  
  func createURLComponents(path: String) -> URLComponents {
    var componentURL = URLComponents()
    componentURL.scheme = "https"
    componentURL.host = "api.github.com"
    componentURL.path = path
    return componentURL
  }
}
