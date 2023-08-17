import Foundation

class HomeScreenViewModel: ObservableObject {
  func onEncodeGistTapped() {
    let newGist = Gist(id: "232", isPublic: true, description: "Hello world")
    
    do {
      let gistData = try JSONEncoder().encode(newGist)
      let stringData = String(data: gistData, encoding: .utf8)
      print(stringData)
    } catch let error {
      print("encoding failed: \(error.localizedDescription)")
    }
  }
  
  func onButtonTapped() {
    DataService.shared.fetchGists { result in
      switch result {
      case .success(let gists):
        for gist in gists {
          print(gist)
        }
      case .failure(let error):
        print("fetching json failed \(error)")
      }
    }
  }
}
