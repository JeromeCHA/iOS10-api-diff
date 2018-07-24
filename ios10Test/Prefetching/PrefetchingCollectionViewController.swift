//
//  PrefetchingCollectionViewController.swift
//  ios10Test
//
//  Created by ジェローム　チャ on 2018/07/19.
//  Copyright © 2018 ジェローム　チャ. All rights reserved.
//

import UIKit

class PrefetchingCollectionViewController: UICollectionViewController {

    private var tasks = [URLSessionTask]()
    private var items = Array(0..<40).compactMap {
        return PrefetchingItem(urlString: "https://dummyimage.com/600x600/9e9e9e/ffffff.png&text=+\($0)+")
    }
    var isPrefetchingEnable = false

    override func viewDidLoad() {
        super.viewDidLoad()
        URLCache.shared.removeAllCachedResponses()
        if isPrefetchingEnable {
            collectionView?.prefetchDataSource = self
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrefetchingCollectionViewCell", for: indexPath) as? PrefetchingCollectionViewCell
        cell?.prefetchingImageView?.image = nil
        cell?.activityIndicator.startAnimating()
        cell?.activityIndicator.isHidden = false
        if let image = items[indexPath.row].image {
            cell?.prefetchingImageView?.image = image
            cell?.activityIndicator.stopAnimating()
            cell?.activityIndicator.isHidden = true
        } else {
            self.downloadImage(at: indexPath.row) { image in
                // Perform UI changes only on main thread.
                DispatchQueue.main.async {
                    cell?.prefetchingImageView.image = image
                    cell?.activityIndicator.stopAnimating()
                    cell?.activityIndicator.isHidden = true
                }
            }
        }
        return cell ?? UICollectionViewCell()
    }

    // MARK: - Image downloading
    fileprivate func downloadImage(at index: Int, completion: ((_ image: UIImage?) -> Void)? = nil) {
        guard items[index].image == nil else { // if image is on cache
            completion?(items[index].image)
            return
        }
        let task = URLSession.shared.dataTask(with: items[index].url) { [weak self] (data, response, error) in
            guard error == nil else {
                print("Error : \(String(describing: error))")
                completion?(nil)
                return
            }
            if let data = data, let image = UIImage(data: data) {
                self?.items[index].image = image
                completion?(image)
            } else {
                completion?(nil)
            }
        }
        task.resume()
        tasks.append(task)
    }

    fileprivate func cancelDownloadingImage(forItemAtIndex index: Int) {
        guard index < tasks.count else { return }
        let task = tasks[index]
        task.cancel()
        tasks.remove(at: index)
    }
}

extension PrefetchingCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 2 - 10
        return CGSize(width: size, height: size)
    }
}

extension PrefetchingCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            print("prefetchRowsAt \(indexPath.row)")
            self.downloadImage(at: indexPath.row)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            print("cancelPrefetchingForRowsAt \(indexPath.row)")
            self.cancelDownloadingImage(forItemAtIndex: indexPath.row)
        }
    }
}
