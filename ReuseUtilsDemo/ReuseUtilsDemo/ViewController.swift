//
//  ViewController.swift
//  ReuseUtilsDemo
//
//  Created by DuanAoiOS on 2018/11/1.
//  Copyright © 2018 DuanAoiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.backgroundColor = UIColor.red
        tv.dataSource = self
        tv.delegate = self
        view.addSubview(tv)
        return tv
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .blue
        cv.dataSource = self
        cv.delegate = self
        view.addSubview(cv)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCollectionView()
        addCollectionConstraints()
        addTableViewConstraints()
    }
}

private extension ViewController {
    
    func setupTableView() {
        tableView.registerClass(UITableViewCell.self)
    }
    
    func setupCollectionView() {
        collectionView.registerClass(UICollectionViewCell.self)
    }
    
    func addCollectionConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: collectionView,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .height,
                                        multiplier: 0.2,
                                        constant: 0)
        let width = NSLayoutConstraint(item: collectionView,
                                        attribute: .width,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .width,
                                        multiplier: 1.0,
                                        constant: 0)
        
        let top = NSLayoutConstraint(item: collectionView,
                                      attribute: .top,
                                      relatedBy: .equal,
                                      toItem: view,
                                      attribute: .top,
                                      multiplier: 1.0,
                                      constant: 0)
        let left = NSLayoutConstraint(item: collectionView,
                                        attribute: .leading,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .leading,
                                        multiplier: 1.0,
                                        constant: 0)
        
        view.addConstraints([top, left, width, height])
    }
    
    func addTableViewConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: tableView,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .height,
                                        multiplier: 0.8,
                                        constant: 0)
        let width = NSLayoutConstraint(item: tableView,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: .width,
                                       multiplier: 1.0,
                                       constant: 0)
        let right = NSLayoutConstraint(item: tableView,
                                       attribute: .trailing,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: .trailing,
                                       multiplier: 1.0,
                                       constant: 0)
        let bottom = NSLayoutConstraint(item: tableView,
                                       attribute: .bottom,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: .bottom,
                                       multiplier: 1.0,
                                       constant: 0)
        view.addConstraints([width, height, right, bottom])
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
}

