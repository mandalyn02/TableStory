//
//  DetailViewController.swift
//  TableStory
//
//  Created by Lewallen, Mandalyn E on 3/19/25.
//

import UIKit

class DetailViewController: UIViewController {
    var item: Item?

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailDesc: UILabel!
    @IBOutlet weak var detailName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailName?.text = item?.name
                        detailDesc?.text = item?.desc
                        detailImage?.image = UIImage(named: item!.imageName)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
