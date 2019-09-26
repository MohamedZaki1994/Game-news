//
//  ViewController.swift
//  Game News
//
//  Created by Mohamed Mahmoud Zaki on 2/8/19.
//  Copyright © 2019 Zaki. All rights reserved.
//

import UIKit
import RealmSwift

class DashboardViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var textView: UITextView!
    let animatorobj = animator()
    var row = 0
    var lastContentOffsetX: CGFloat = 0.0
    var timer: Timer?
    var arrowIcon = [UIImageView]()
    var dashboardInteractor = DashboardInteractor()
    var imageArray: [String] = []
    var detailedText: [String] = []
    var viewModel = DashboardViewModel()
    var viewHeightCollapsed: NSLayoutConstraint?
    var viewHeightExtended: NSLayoutConstraint?
    let gradient = CAGradientLayer()
    var isSideMenu = false
    let factory = AppFactory()
    var sideMenu: SideMenuViewController?
    let clearView = UIView()

    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func myFavorite(_ sender: Any) {
        guard let favoriteVC = factory.makeViewController(with: .FavoriteViewController) as? FavoriteViewController else {
            return
        }
        present(favoriteVC, animated: true, completion: nil)
    }

    func closeSideMenu() {
        removeClearView()
        UIView.animate(withDuration: 0.5, animations: {
            self.sideMenu?.view.frame = CGRect(x: self.view.frame.maxX, y: 100, width: self.view.frame.midX, height: self.view.frame.maxY)
        }) { [weak self] (_) in
            self?.unEmbed(child: SideMenuViewController.self)
            self?.isSideMenu = false
        }
    }

    func openSideMenu() {
        addingcClearView()
        let sideMenuViewController = factory.makeViewController(with: .SideMenuViewController)
        sideMenu = sideMenuViewController as? SideMenuViewController
        sideMenu?.delegate = self
        embed(child: sideMenuViewController)
        sideMenuViewController.view.frame = CGRect(x: view.frame.maxX, y: 100, width: view.frame.midX, height: view.frame.maxY)
        UIView.animate(withDuration: 0.5) {
            sideMenuViewController.view.frame = CGRect(x: self.view.frame.midX, y: 100, width: self.view.frame.midX, height: self.view.frame.maxY)

        }
        isSideMenu = true
    }
    func addingcClearView() {
        clearView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clearView)
        clearView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        clearView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        clearView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        clearView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (dismissSideMenu))
        clearView.addGestureRecognizer(tap)
    }

    func removeClearView() {
        clearView.gestureRecognizers?.removeAll()
        clearView.removeFromSuperview()
    }

    @IBAction func sideMenuAction(_ sender: Any) {
        if isSideMenu {
            closeSideMenu()
        } else {
            openSideMenu()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let wrappedcell = cell as? DashboardCollectionViewCell else {
            return cell
        }
        wrappedcell.title.text = "hello\(indexPath.row)"
        wrappedcell.imageView.image = UIImage(named: imageArray[indexPath.row])
        return wrappedcell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dashboardInteractor.getData { (model) in
            guard let games = model.games else {
                return
            }
            imageArray = games.compactMap({ game in
                return game.name
            })
            detailedText = games.compactMap({ game in
                return game.text
            })
            pageController.numberOfPages = imageArray.count
            self.collectionView.reloadData()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(didFinished), name: Notification.Name("didReceiveData"), object: nil)
        setupStackView()
        dashboardInteractor.testNotification()
        hyperLink()
    }

    @objc func dismissSideMenu() {
        if isSideMenu {
            closeSideMenu()
        }
    }

    func hyperLink() {
        textView.delegate = self
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        let attributedString = NSMutableAttributedString(string: "Settings")
        let url = settingsUrl
        let range = NSMakeRange(0, attributedString.length)
        attributedString.setAttributes([.link: url], range: range)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: range)
        self.textView.attributedText = attributedString
        self.textView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.double.rawValue
        ]
    }

    deinit {
        timer?.invalidate()
        timer = nil
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
        NotificationCenter.default.removeObserver(self)
    }

    @objc func didFinished(nsNotification: Notification) {
        guard let data = nsNotification.userInfo as? [String: String] else {
            return
        }
        print(data)
    }
    fileprivate func gradientBackground() {
        view.layer.insertSublayer(gradient, at: 0)
        gradient.bounds = view.bounds
        gradient.anchorPoint = CGPoint.zero
        let red = UIColor.red.cgColor
        let blue = UIColor.blue.cgColor
        gradient.colors = [red, blue]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        navigationController?.navigationBar.isHidden = true
        gradientBackground()
    }

    @objc func timerAction() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
                self.row += 1
                self.lastContentOffsetX += self.collectionView.frame.width
                if self.row == self.imageArray.count {
                    self.row = 0
                    self.lastContentOffsetX = 0.0
                }
                self.pageController.currentPage = self.row
                let index = IndexPath(row: self.row, section: 0)
            self.collectionView.scrollToItem(at: index, at: .right , animated: true)
                self.view.layoutIfNeeded()
                self.collectionView.layoutIfNeeded()
               
            })
        }
        
    }

    func setupStackView() {
        for imj in imageArray.enumerated() {
            let image = UIImage(named: imj.element)
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let label = UILabel()
            label.text = "Test"
            label.translatesAutoresizingMaskIntoConstraints = false
            let view = CustomView()
            view.addSubview(imageView)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.viewHeightCollapsed = view.heightAnchor.constraint(equalToConstant: 120)
                view.viewHeightCollapsed?.isActive = true
            view.more = label
            arrowIcon.append(UIImageView(image: UIImage(named: "arrowDown")))
            arrowIcon[imj.offset].backgroundColor = .red
            view.addSubview(arrowIcon[imj.offset])
            addIcon(imj, view)
            view.addSubview(label)
            addingLabel(label, imageView, view)
            let tap = UITAPGesture(target: self, action: #selector(handleAction))
            tap.tapedView = view
            tap.isOpened = false
            tap.index = imj.offset
            tap.tapedView?.icon = arrowIcon[imj.offset]
            stackView.addArrangedSubview(view)
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
        }
    }

    fileprivate func addingLabel(_ label: UILabel, _ imageView: UIImageView, _ view: CustomView) {
        label.textColor = .red
        label.numberOfLines = 0
        label.text = "See more"
        label.textColor = .white
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let recognizerView = recognizer.view else{ return }
        let translation = recognizer.translation(in: recognizerView)
        recognizerView.center.x += translation.x
        recognizerView.center.y += translation.y
        recognizer.setTranslation(.zero, in: view)
    }

    fileprivate func addIcon(_ imj: (offset: Int, element: String), _ view: CustomView) {
        arrowIcon[imj.offset].translatesAutoresizingMaskIntoConstraints = false
        arrowIcon[imj.offset].heightAnchor.constraint(equalToConstant: 20).isActive = true
        arrowIcon[imj.offset].widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowIcon[imj.offset].trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        arrowIcon[imj.offset].bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

    @objc func handleAction(sender: UITAPGesture) {
        guard let tapedView = sender.tapedView,
        let isOpened = sender.isOpened,
        let icon = sender.tapedView?.icon,
        let index = sender.index else {return}
        if isOpened {
            tapedView.more?.alpha = 0.25
            UIView.animate(withDuration: 1) {
                tapedView.more?.alpha = 1
                tapedView.more?.text = "See more"
                tapedView.viewHeightExtended?.isActive = false
                tapedView.viewHeightCollapsed?.isActive = true //tapedView.heightAnchor.constraint(equalToConstant: 100).isActive = true
                sender.isOpened = false
                icon.transform = CGAffineTransform(rotationAngle: CGFloat(0))
                self.view.layoutIfNeeded()
            }
        } else {
            tapedView.more?.alpha = 0.25
            UIView.animate(withDuration: 1) {
                tapedView.more?.alpha = 1
                tapedView.more?.text = self.detailedText[index]
                tapedView.viewHeightCollapsed?.isActive = false
                tapedView.viewHeightExtended = tapedView.heightAnchor.constraint(equalToConstant: 200)
                tapedView.viewHeightExtended?.isActive = true
                sender.isOpened = true
                icon.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                self.view.layoutIfNeeded()
            }
        }
    }
}


extension DashboardViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if UIApplication.shared.canOpenURL(URL) {
            UIApplication.shared.open(URL)
        }
        return false
    }
}
