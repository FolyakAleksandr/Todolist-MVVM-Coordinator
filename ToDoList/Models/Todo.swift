struct ResponseData: Codable {
    let todos: [DataItem]
}

struct DataItem: Codable {
    let todo: String
    let completed: Bool
}
