import Foundation

struct Gist: Codable {
  var id: String
  var isPublic: Bool
  
  enum CodingKeys: String, CodingKey {
    case id, isPublic = "public"
  }
}



