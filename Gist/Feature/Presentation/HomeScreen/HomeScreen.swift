import SwiftUI

struct HomeScreen: View {
  @ObservedObject var viewModel: HomeScreenViewModel
  
  var body: some View {
      VStack {
          Image(systemName: "globe")
              .imageScale(.large)
              .foregroundColor(.accentColor)
        HStack {
          Button(
            "Encode new gist",
            action: viewModel.onEncodeGistTapped
          )
          Text(" | ")
          Button(
            "Star gist",
            action: viewModel.onStarGistTapped
          )
        }
        .padding()
        Button(
          "Fetch gists",
          action: viewModel.onButtonTapped
        )
        List {
          ForEach(viewModel.feedGists) { item in
            ListItem(
              id: item.id,
              description: item.description
            )
          }
        }
      }
      .padding()
  }
}

struct HomeScreen_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen(viewModel: HomeScreenViewModel())
  }
}
