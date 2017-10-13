//
//  TableHelper.swift
//  Demo
//
//  Created by Duanao on 2017/10/13.
//  Copyright © 2017年 duanao.com. All rights reserved.
//

import UIKit

/// 重用标识
protocol Reuseable: class {
    static var reuseIdentifier: String { get }
}

extension Reuseable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

extension UITableViewCell: Reuseable {}

/// Nib加载
protocol NibLoadable {
    static var nibName: String {get}
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return "\(self)"
    }

    /// 加载Xib描述的UI控件
    ///
    /// - Parameter nibName: Xib文件名 默认与类名一致
    /// - Returns: 返回加载的UI对象
    static func loadFromNib(_ nibName: String? = nil) -> Self {
        let nib = nibName ?? "\(self)"
        return Bundle.main.loadNibNamed(nib, owner: nil, options: nil)?.first as! Self
    }
}

extension UITableViewCell : NibLoadable {}


extension UITableView {

    /// 注册用Xib描述的Cell
    ///
    /// - Parameter _: 该Cell的Class类型
    func registerNib<T: UITableViewCell>(_: T.Type)  {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    /// 注册普通Cell
    ///
    /// - Parameter _: 该Cell的Class类型
    func registerClass<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    /// 从缓存池中取出复用的Cell
    ///
    /// - Parameter indexPath: 对应数据源的IndexPath
    /// - Returns: 返回与声明类型一致的Cell exp:let cell: TypeCell = tableView.dequeueReusableCell(for: indexPath）
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("不能从缓存池取出Cell identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
