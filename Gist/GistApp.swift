//

import SwiftUI

@main
struct GistApp: App {
    var body: some Scene {
        WindowGroup {
            HomeScreen(viewModel: HomeScreenViewModel())
        }
    }
}
