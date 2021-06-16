import Foundation

struct JSONObject: Codable, Equatable {
    let integer: Int

    init(_ integer: Int = 1) {
        self.integer = integer
    }

    var data: Data? {
        return try? JSONEncoder().encode(self)
    }
}

