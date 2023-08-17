//

import SwiftUI

struct HomeScreen: View {
  @ObservedObject var viewModel: HomeScreenViewModel
  
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
      HomeScreen(viewModel: HomeScreenViewModel())
    }
}
