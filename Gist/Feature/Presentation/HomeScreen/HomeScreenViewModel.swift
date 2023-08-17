import Foundation

class HomeScreenViewModel: ObservableObject {
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
