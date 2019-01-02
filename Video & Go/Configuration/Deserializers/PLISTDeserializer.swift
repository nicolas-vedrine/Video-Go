/*
 * Copyright IBM Corporation 2017
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation

/// Default PLIST deserializer implementation.
///
/// Deserializes PLIST formatted data using Foundation's PropertListSerialization class.
public class PLISTDeserializer: Deserializer {
    /// A shared `PLISTDeserializer` instance.
    public static let shared = PLISTDeserializer()

    /// A unique name that identifies this deserializer.
    public let name = "plist"

    /// Function that deserializes raw PLIST data into a Foundation object.
    ///
    /// - Parameter data: The raw PLIST data to be deserialized.
    public func deserialize(data: Data) throws -> Any {
        return try PropertyListSerialization.propertyList(from: data, format: nil)
    }

    // No need to create multiple instances of PLISTDeserializer
    private init() {}
}
