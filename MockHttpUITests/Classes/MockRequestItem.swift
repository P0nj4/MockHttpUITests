//
//  MockRequestItem.swift
//  Pods
//
//  Created by German Pereyra on 3/30/17.
//
//

import Foundation

public class MockRequestItem: NSObject {
    var requestPath: String?
    var responseFileName: String?
    var removeAfterCalled: Bool = false
    var responseHTTPCode: Int32?
    var requestMethod: String!

    public convenience init(requestPath: String, responseFileName: String, responseHTTPCode: Int32, removeAfterCalled: Bool = false, requestMethod: String) {
        self.init()
        self.requestPath = requestPath
        self.responseFileName = responseFileName
        self.responseHTTPCode = responseHTTPCode
        self.removeAfterCalled = removeAfterCalled
        self.requestMethod = requestMethod
    }

    public func toJsonString() -> String {
        // swiftlint:disable line_length
        return "{\"requestPath\": \"\(requestPath!)\", \"responseFileName\": \"\(responseFileName!)\", \"removeAfterCalled\": \(removeAfterCalled), \"responseHTTPCode\": \(responseHTTPCode!), \"requestMethod\": \"\(requestMethod!)\"}"
        // swiftlint:enable line_length
    }

    public convenience init?(jsonString: String) {
        guard let dict = MockRequestItem.convertToDictionary(text: jsonString),
            let requestPath = dict["requestPath"] as? String,
            let responseFileName = dict["responseFileName"] as? String,
            let requestMethod = dict["requestMethod"] as? String,
            let removeAfterCalled = dict["removeAfterCalled"] as? Bool,
            let responseHTTPCode = dict["responseHTTPCode"] as? Int32 else {
                return nil
        }
        print("NEW REQUEST MOCKED UP: \(jsonString)")
        self.init(requestPath: requestPath, responseFileName: responseFileName, responseHTTPCode: responseHTTPCode, removeAfterCalled: removeAfterCalled,requestMethod: requestMethod)
    }

    public static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                //print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
