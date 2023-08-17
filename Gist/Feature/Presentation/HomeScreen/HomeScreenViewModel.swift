import Foundation

class HomeScreenViewModel: ObservableObject {
  var feedGists: [Gist] = []
  
  func onButtonTapped() {
    DataService.shared.fetchGists { result in
      switch result {
      case .success(let gists):
        self.feedGists = gists
        for gist in gists {
          print(gist)
        }
      case .failure(let error):
        print("fetching json failed \(error)")
      }
    }
  }
  
  func onEncodeGistTapped() {
    DataService.shared.createNewGist { result in
      switch result {
      case .success(let gists):
        for gist in gists {
          print("\(gist)\n")
        }
      case .failure(let error):
        print("creating new gist failed \(error.localizedDescription)")
      }
    }
  }
  
  func onStarGistTapped() {
    DataService.shared.starUnstarGist(id: "34334", isStarred: true) { success in
      if success {
        print("starring successful")
      } else {
        print("starring failed")
      }
    }
  }
}
