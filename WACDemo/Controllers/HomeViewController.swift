//
//  ViewController.swift
//  WACDemo
//
//  Created by Apple on 09/11/22.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    @IBOutlet weak var BannerCollectionView: UICollectionView!
    @IBOutlet weak var CategoryListCollectionView: UICollectionView!
    
    var homeDataModel: HomeDataModel?
    var categoryDataModel = [HomeData]()
    var bannerDataModel = [HomeData]()
    var categoryListDataModel = [HomeData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDecoration()
    }
    
    //MARK: - UIDecorations
    
    private func UIDecoration() {
        txtSearch.layer.borderColor = UIColor.lightGray.cgColor
        txtSearch.layer.borderWidth = 0.8
        fetchHomeDataFromServer(with: "https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0")
        txtSearch.addLeftIcon()
        txtSearch.addRightIcon()
        txtSearch.layer.cornerRadius = 8.0
    }
    
}

//MARK: - CategoryCollectionViewCell Class

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
}

//MARK: - BannerCollectionViewCell Class

class BannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
}

//MARK: - CategoryListCollectionViewCell Class

class CategoryListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var vwOffer: UIView!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var imgFavorite: UIImageView!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
}

//MARK: - UICollectionView Delegate and DataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CategoryCollectionView {
            return categoryDataModel[0].values.count
        } else if collectionView == BannerCollectionView {
            return bannerDataModel[0].values.count
        } else {
            return categoryListDataModel[0].values.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == CategoryCollectionView {
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            categoryCell.imgCategory.layer.cornerRadius = categoryCell.imgCategory.frame.size.height / 2
            let categoryData = categoryDataModel[0].values[indexPath.item]
            if let imgURL = categoryData.imageURL {
                let img = URL(string: imgURL)!
                categoryCell.imgCategory.kf.setImage(with: img)
            }
            categoryCell.lblCategoryName.text = categoryData.name
            return categoryCell
        } else if collectionView == BannerCollectionView {
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
            let bannerData = bannerDataModel[0].values[indexPath.row]
            bannerCell.imgBanner.layer.cornerRadius = 8.0
            if let imgURL = bannerData.bannerURL {
                let img = URL(string: imgURL)!
                bannerCell.imgBanner.kf.setImage(with: img)
            }
            let bannerCollecctionViewSize = BannerCollectionView.frame.size
            bannerCell.imgWidth.constant = bannerCollecctionViewSize.width * 0.9
            return bannerCell
        } else {
            let categoryListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryListCollectionViewCell", for: indexPath) as! CategoryListCollectionViewCell
            categoryListCell.layer.borderWidth = 1.0
            categoryListCell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
            categoryListCell.layer.cornerRadius = 8.0
            categoryListCell.btnAdd.layer.cornerRadius = 8.0
            categoryListCell.imgItem.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            addofferShape(cell: categoryListCell)
            categoryListCell.lblOffer.textColor = UIColor.white
            let listData = categoryListDataModel[0].values[indexPath.row]
            if let offer = listData.offer, let img = listData.image, let offerPrice = listData.offerPrice, let price = listData.actualPrice, let name = listData.name {
                let imgURL = URL(string: img)!
                let attr1 = NSMutableAttributedString(string: "\(offerPrice)\n", attributes: [.foregroundColor: UIColor.lightGray, .strikethroughColor: UIColor.lightGray, .strikethroughStyle: 2, .font: UIFont.systemFont(ofSize: 12.0, weight: .medium)])
                let attr2 = NSAttributedString(string: "\(price)\n", attributes: [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 13.0, weight: .bold)])
                let attr3 = NSAttributedString(string: name, attributes: [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)])
                attr1.append(attr2)
                attr1.append(attr3)
                categoryListCell.lblOffer.text = "\(offer)% OFF"
                categoryListCell.imgItem.kf.setImage(with: imgURL)
                categoryListCell.lblDetails.attributedText = attr1
            }
            return categoryListCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == CategoryCollectionView {
            let categoryCollectionViewSize = CategoryCollectionView.frame.size
            return CGSize(width: 50.0, height: categoryCollectionViewSize.height)
        } else if collectionView == BannerCollectionView {
            let bannerCollecctionViewSize = BannerCollectionView.frame.size
            return CGSize(width: bannerCollecctionViewSize.width * 0.9, height: bannerCollecctionViewSize.height)
        } else {
            let categoryListCollecctionViewSize = CategoryListCollectionView.frame.size
            return CGSize(width: 150.0, height: categoryListCollecctionViewSize.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func addofferShape(cell: CategoryListCollectionViewCell) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: cell.vwOffer.frame.size.width, y: 0.0))
        path.addLine(to: CGPoint(x: cell.vwOffer.frame.size.width * 0.85, y: cell.vwOffer.frame.size.height / 2))
        path.addLine(to: CGPoint(x: cell.vwOffer.frame.size.width, y: cell.vwOffer.frame.size.height))
        path.addLine(to: CGPoint(x: 0.0, y: cell.vwOffer.frame.size.height))
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.red.cgColor
        shape.path = path.cgPath
        cell.vwOffer.layer.insertSublayer(shape, at: 0)
        
    }
    
    
    
}


//MARK: - Network Call


extension HomeViewController {
    
    //Fetching data from server using alamofire
    
    private func fetchHomeDataFromServer(with url: String) {
        CustomActivityIndicator.showActivityIndicator(uiView: self.view)
        NetworkHandler.sharedNetwork.networkCall(with: url) { [self] response, isSucess, status in
            if isSucess {
                let data = response!
                do {
                    homeDataModel = try JSONDecoder().decode(HomeDataModel.self, from: data)
                    categoryDataModel = homeDataModel!.homeData.filter({$0.type == "category"})
                    bannerDataModel = homeDataModel!.homeData.filter({$0.type == "banners"})
                    categoryListDataModel = homeDataModel!.homeData.filter({$0.type == "products"})
                    CategoryCollectionView.delegate = self
                    BannerCollectionView.delegate = self
                    CategoryListCollectionView.delegate = self
                    
                    CategoryCollectionView.dataSource = self
                    BannerCollectionView.dataSource = self
                    CategoryListCollectionView.dataSource = self
                    CategoryCollectionView.reloadData()
                    BannerCollectionView.reloadData()
                    CategoryListCollectionView.reloadData()
                } catch let err {
                    print(err.localizedDescription)
                }
                CustomActivityIndicator.hideActivityIndicator(uiView: self.view)
            } else {
                
                CustomActivityIndicator.hideActivityIndicator(uiView: self.view)
            }
        }
    }
    
}
