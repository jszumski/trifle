//
//  DERUTCTime.swift
//  SecuritySdk
//

import Foundation

/// UTCTime DER (Distingushed Encoding Rules) encodable
public struct DERUTCTime: ASN1Type, DEREncodable {
    public typealias T = Date
        
    // MARK: - Public Properties

    public let tag: Octet
    public let octets: [Octet]

    // MARK: - Initialization
    
    public init(_ rawValue: Date, _ type: Type = Type.none) throws {
        self.octets = try Self.encode(rawValue, .utcTime(type))
        self.tag = octets.first!
    }
    
    internal static func encodeValue(_ rawValue: Date) -> [Octet] {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyMMddHHmmss'Z'"
        return dateFormatter.string(for: rawValue)!.compactMap { $0.asciiValue }
    }
}