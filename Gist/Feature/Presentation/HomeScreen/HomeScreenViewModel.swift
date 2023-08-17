import Foundation

class HomeScreenViewModel: ObservableObject {
  func onButtonTapped() {
    DataService.shared.fetchGists { result in
      switch result {
      case .success(let json):
        print(json)
      case .failure(let error):
        print("fetching json failed \(error)")
      }
    }
  }

  func onAppear() {
    DataService.shared.fetchGists { result in
      switch result {
      case .success(let json):
        print(json)
      case .failure(let error):
        print("fetching json failed \(error)")
      }
    }
  }
}
