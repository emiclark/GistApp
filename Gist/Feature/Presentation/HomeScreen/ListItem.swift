import SwiftUI

struct ListItem: View {
  let id: String
  let description: String
  let isPublic: Bool = true
  
  var body: some View {
      contentView
  }
  
  private var contentView: some View {
    VStack(alignment: .leading) {
        Text("id: \(id)")
        .font(.footnote)
        Text("description: \(description)")
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(10)
      .padding(.horizontal, 10)
      .font(.title3)
  }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
      VStack {
        ListItem(id: "234", description: "hello world")
        ListItem(id: "234", description: "hello world")
      }
      .background(.yellow)
    }
}
