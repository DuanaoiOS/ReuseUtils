//
//  ReuseUtils.swift
//  Demo
//
//  Created by Duanao on 2017/10/13.
//  Copyright © 2017年 duanao.com. All rights reserved.
//

import UIKit


// MARK: -  Reuseable
public protocol Reuseable: class {
    static var reuseIdentifier: String { get }
}

// Reuse identifying
public extension Reuseable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

public extension Reuseable where Self: UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

public extension Reuseable where Self: UICollectionReusableView {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}


// MARK: -  NibLoadable
public protocol NibLoadable {
    static var nibName: String {get}
}

public extension NibLoadable where Self: UIView {
    
    static var nibName: String {
        return "\(self)"
    }

    ///  Load the controls described using XIB
    ///
    /// - Parameter nibName: Xib filename
    /// - Returns: The control
    public static func loadFromNib() -> Self {
        return Bundle(for: classForCoder()).loadNibNamed(nibName, owner: nil, options: nil)?.first as! Self
    }
    
    ///  Load the XIB file to specify the position control
    ///
    /// - Parameter index: position
    /// - Returns: The control
    public static func loadFromNib(index: Int) -> Self? {
        guard let nibArr = Bundle(for: classForCoder()).loadNibNamed(nibName, owner: nil, options: nil) else {
            return nil
        }
        return nibArr[index] as? Self
    }
}

extension UITableViewCell: Reuseable {}
extension UITableViewHeaderFooterView: Reuseable {}
extension UICollectionReusableView: Reuseable {}

extension UITableViewCell : NibLoadable {}
extension UICollectionReusableView: NibLoadable {}
extension UITableViewHeaderFooterView: NibLoadable {}

// MARK: -  Extensions of UITableView
public extension UITableView {

    /// Register the Cell described by Xib
    ///
    /// - Parameter _: Class Type of Cell
    public func registerNib<T: UITableViewCell>(_: T.Type)  {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Register HeaderFooterView described by Xib
    ///
    /// - Parameter _: Class Type of HeaderFooterView
    public func registerNib<T: UITableViewHeaderFooterView> (forHeaderFooter _: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    /// Register a regular Cell
    ///
    /// - Parameter _: Class Type of Cell
    public func registerClass<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Register a regular HeaderFooterView
    ///
    /// - Parameter _: Class Type of HeaderFooterView
    public func registerClass<T: UITableViewHeaderFooterView>(forHeaderFooter _: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    /// Reuse the multiplexed Cell from the cache pool
    ///
    /// - Parameter indexPath: IndexPath
    /// - Returns: Object of this type
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Cannot be taken from the cache pool. cell identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    /// Reuse the multiplexed HeaderFooterView from the cache pool
    ///
    /// - Returns: Object of this type
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Cannot be taken from the cache pool. HeaderFooterView identifier: \(T.reuseIdentifier)")
        }
        return headerFooterView
    }
}

// MARK: -  Extensions of UICollectionView
public extension UICollectionView {
    
    /// Register the Cell described by Xib
    ///
    /// - Parameter _: Class Type of Cell
    public func registerNib<T: UICollectionViewCell>(_: T.Type)  {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Register HeaderFooterView described by Xib
    ///
    /// - Parameter _: Class Type of ReusableView
    /// - Parameter _: The kind for SupplementaryView
    public func registerNib<T: UICollectionReusableView>(_: T.Type, kind: String? = nil)  {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        guard let k = kind else {
            fatalError("Register\(T.reuseIdentifier)Need to pass in valid kind")
        }
        register(nib, forSupplementaryViewOfKind: k, withReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Register a regular Cell
    ///
    /// - Parameter _: Class Type of Cell
    public func registerClass<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        
    }
    
    /// Register a regular ReusableView
    ///
    /// - Parameter _: Class Type of ReusableView
    public func registerClass<T: UICollectionReusableView>(_: T.Type, kind: String? = nil) {
        guard let k = kind else {
            fatalError("Register\(T.reuseIdentifier)Need to pass in valid kind")
        }
        register(T.self, forSupplementaryViewOfKind: k, withReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Reuse the multiplexed Cell from the cache pool
    ///
    /// - Parameter indexPath: IndexPath
    /// - Returns: Object of this type
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Cannot be taken from the cache pool. Cell identifier: \(T.reuseIdentifier)")
        }
        return cell
        
    }
    
    /// Reuse the multiplexed ReusableView from the cache pool
    ///
    /// - Parameter indexPath: IndexPath
    /// - Returns: Object of this type
    public func dequeueReusableCell<T: UICollectionReusableView>(for indexPath: IndexPath, kind: String? = nil) -> T {
        guard let k = kind, let supplementaryView = dequeueReusableSupplementaryView(ofKind: k, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Cannot be taken from the cache pool. SupplementaryView identifier: \(T.reuseIdentifier)")
        }
        return supplementaryView
    }
}
