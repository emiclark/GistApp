import Foundation

class HomeScreenViewModel: ObservableObject {
  func onAppear() {
    DataService.shared.fetchGists()
  }
}
