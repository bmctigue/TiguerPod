//
//  Protocols.swift
//  Tiguer
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Promis

public typealias VCBuilderBlock = ((UIViewController) -> Void)

public protocol BaseBuilder: AnyObject {
    func run()
}

public protocol VCBuilder: AnyObject {
    func run(completionHandler: VCBuilderBlock)
}

public protocol StoreProtocol {
    func fetchData(_ url: URL?) -> Future<Store.Result>
}

public protocol DataAdapterProtocol: AnyObject {
    associatedtype Model
    func itemsFromData(_ data: Data) -> Future<DataAdapterResult.Result<Model>>
}

public protocol ServiceProtocol: AnyObject {
    associatedtype Model: Codable
    func fetchItems(_ request: Request, url: URL?, completionHandler: @escaping ([Model]) -> Void)
}

public protocol InteractorProtocol: AnyObject {
    func fetchItems(_ request: Request, url: URL?)
}

public protocol PresenterProtocol: AnyObject {
    associatedtype Model
    func updateViewModels(_ response: Response<Model>)
}

public protocol NetworkSession {
    func loadData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void)
}

public protocol URLGenerator {
    func url() -> URL?
    func queryItemsFromRequest(_ request: Request) -> [URLQueryItem]?
}

extension URLGenerator {
    public func queryItemsFromRequest(_ request: Request) -> [URLQueryItem]? {
        guard !request.params.isEmpty else {
            return nil
        }
        var queryItems = [URLQueryItem]()
        for (key, value) in request.params where key != Tiguer.Constants.forceKey {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        return queryItems
    }
}

public protocol CacheProtocol {
    associatedtype CacheObject
    func setObject<CacheObject: Codable>(_ object:CacheObject, forKey key:String)
    func getObjectForKey<CacheObject>(_ key: String) -> CacheObject? where CacheObject : Decodable, CacheObject : Encodable
    func removeObjectForKey(_ key:String)
}

public protocol StoryboardFactoryProtocol {
    func create(name: String, bundle: Bundle) -> UIStoryboard
}
