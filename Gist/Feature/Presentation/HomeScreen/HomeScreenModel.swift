import Foundation

struct Gist: Identifiable, Encodable {
  var id: String
  var isPublic: Bool
  var description: String
  var files: [String: File]
  
  enum CodingKeys: String, CodingKey {
    case id, description, contents, files, isPublic = "public"
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(isPublic, forKey: .isPublic)
    try container.encodeIfPresent(description, forKey: .description)
    try container.encode(files, forKey: .files)
  }
}

extension Gist: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.isPublic = try container.decode(Bool.self, forKey: .isPublic)
    self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? "Description is nil"
    self.files = try container.decode([String: File].self, forKey: .files)
  }
}

struct File: Codable {
  var content: String?
}
