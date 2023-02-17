//
//  ASN1PrintableString.swift
//  SecuritySdk
//

import Foundation

/// ASN.1 PrintableString with DER (Distingushed Encoding Rules) encodable
public struct ASN1PrintableString: ASN1Type, DEREncodable {
    public typealias T = String

    // MARK: - Public Properties

    public let tag: Octet
    public let octets: [Octet]

    // MARK: - Initialization
    
    public init(_ rawValue: String, _ type: Type = Type.none) throws {
        guard rawValue.range(
            of: "^[a-zA-Z0-9'()+,-./:=? ]*$",
            options: .regularExpression,
            range: nil,
            locale: nil
        ) != nil else {
            throw DEREncodableError.invalidInput("Illegal character(s) present")
        }

        self.octets = try Self.encode(rawValue, .printableString(type))
        self.tag = octets.first!
    }

    // MARK: - Internal static methods (DEREncodable)

    internal static func encodeValue(_ rawValue: String) -> [Octet] {
        return rawValue.compactMap { $0.asciiValue }
    }
}