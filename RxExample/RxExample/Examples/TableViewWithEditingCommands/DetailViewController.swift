//
//  DetailViewController.swift
//  RxExample
//
//  Created by carlos on 26/5/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import UIKit
import RxSwift

class DetailViewController: ViewController {
    
    var user: User!
    
    let `$` = Dependencies.sharedDependencies
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
                
        imageView.makeRoundedCorners(40)
        
        let url = URL(string: user.imageURL)!
        let request = URLRequest(url: url)
        
        URLSession.shared.rx.data(request: request)
            .map { data in
                UIImage(data: data)
            }
            .observe(on:`$`.mainScheduler)
            .catchErrorJustReturn(nil)
            .subscribe(imageView.rx.image)
            .disposed(by: disposeBag)
        
        label.text = user.firstName + " " + user.lastName
    }

}
