import Foundation

class DataService {
  static let shared = DataService()
  
  fileprivate let baseURLString = "https://api.github.com"
  
  func fetchGists(completion: @escaping (Result<[Gist], Error>) -> Void) {
    let componentURL = createURLComponents(path: "/gists/public")
    guard let validURL = componentURL.url
    else {
      print(">> url failed")
      return
    }
    
    print(">> url: \(validURL)")
    
    URLSession.shared.dataTask(with: URLRequest(url: validURL)) { (data, response, error) in
      if let response = response as? HTTPURLResponse {
        print("status code: \(response.statusCode)")
      }
      
      guard let validData = data, error == nil
      else {
        completion(.failure(error!))
        return
      }

      do {
        let gists = try JSONDecoder().decode([Gist].self, from: validData)
        print(gists)
        completion(.success(gists))
      } catch let error {
        print(error)
      }
      
    }.resume()
  }
  
  func createAuthCredentials() -> String {
      // getting auth failure: status code: 401 - creating new gist failed The data couldn’t be read because it isn’t in the correct format.
    let authString = "Token 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"
    var authStringBase64 = ""
    if let authData = authString.data(using: .utf8) {
      authStringBase64 = authData.base64EncodedString()
    }
    return authStringBase64
  }
  
  // POST new gist
  func createNewGist(completion: @escaping (Result<[Gist], Error>) -> Void) {
    // create new gist
    let newGist = Gist(id: nil, isPublic: true, description: "a new gist", files: ["gist.txt" : File(content: "it's almost there")])
                                                                                   
    let postComponents = createURLComponents(path: "/gists")
    guard let composedURL = postComponents.url
    else {
      print("url creation failed")
      return
    }
    
    var postRequest = URLRequest(url: composedURL)
    postRequest.httpMethod = "POST"
    
    // add authorization to body
    postRequest.setValue("Basic \(createAuthCredentials())", forHTTPHeaderField: "Authorization")
    postRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
    postRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    
    // encode gist
    do {
      let gistData = try JSONEncoder().encode(newGist)
      postRequest.httpBody = gistData
    } catch {
      print("gist encoding failed")
    }
    
    // create network session and set headers
    URLSession.shared.dataTask(with: postRequest) { (data, response, error) in
      if let response = response as? HTTPURLResponse {
        print("status code: \(response.statusCode)")
      }
      
      guard let validData = data, error == nil else {
        completion(.failure(error!))
        return
      }
      
      do {
//        let json = try JSONSerialization.jsonObject(with: validData, options: [])
        let gists = try JSONDecoder().decode([Gist].self, from: validData)
        completion(.success(gists))
      } catch let error {
        completion(.failure(error))
      }
    }.resume()
  }
  
  func createURLComponents(path: String) -> URLComponents {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.github.com"
    components.path = path
    return components
  }
  
  func starUnstarGist(id: String, isStarred: Bool, completion: @escaping(Bool) -> Void) {
    let starComponents = createURLComponents(path: "/gists/\(id)/star")
    guard let composedURL = starComponents.url else {
      print("url failed")
      return
    }
    
    var starRequest = URLRequest(url: composedURL)
    starRequest.httpMethod = isStarred ? "PUT" : "DELETE"
    starRequest.setValue("0", forHTTPHeaderField: "Content-Length")
    starRequest.setValue("Basic \(createAuthCredentials())", forHTTPHeaderField: "Authorization")
    
    // create network session
    URLSession.shared.dataTask(with: starRequest) { (data, response, error) in
      if let httpResponse = response as? HTTPURLResponse {
        print(httpResponse.statusCode)
        if httpResponse.statusCode == 204 {
          completion(true)
        } else {
          completion(false)
        }
      }
    }.resume()
  }
}
