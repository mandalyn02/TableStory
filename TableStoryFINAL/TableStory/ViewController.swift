//
//  ViewController.swift
//  TableStory
//
//  Created by Lewallen, Mandalyn E on 3/17/25.
//

import UIKit
import MapKit
//array objects of our data.
let data = [
    Item(name: "The Avenue", neighborhood: "1111 Avalon Avenue", desc: "The Avenue at San Marcos is a student-oriented apartment community offering fully furnished units with modern amenities. Residents can enjoy a large fitness center, tanning beds, a resort-style pool, basketball and sand volleyball courts, and a yoga studio. Additional features include a movie theater, golf simulator, game room with pool tables, and a cyber café with computer labs. The complex is conveniently situated near Texas State University, providing easy access to campus via the Bobcat Tram Route.", lat: 29.907182, long: -97.899727, imageName: "image1"),
    Item(name: "The Thompson", neighborhood: "1655 Mill Street", desc: "The Thompson is a student-focused apartment community in San Marcos, Texas, offering fully furnished 4-bedroom flats and townhomes. Each unit features private bedrooms and bathrooms, full-sized kitchens with stainless steel appliances, and private patios or balconies. Residents can enjoy amenities such as a beach-entry swimming pool with sun cabanas, a fitness center, a volleyball court, a 24-hour clubhouse with a coffee bar, and a tech center with iMac computers and free printing.", lat:  29.8992, long: -97.9147, imageName: "image2"),
    Item(name: "The Retreat", neighborhood: "512 Craddock Avenue", desc: "The Retreat at San Marcos is a student-focused housing community offering fully furnished 2, 3, 4, and 5-bedroom cottages near Texas State University. Each unit features private bedrooms and bathrooms, stainless steel appliances, granite countertops, and hardwood-style flooring. Residents can enjoy amenities such as a state-of-the-art fitness center, recreation center with billiards and foosball, swimming pool with spa and sun deck, basketball and sand volleyball courts, and a golf simulator. The community is conveniently located on the Bobcat Tram Bus Route, providing easy access to campus.", lat:  29.8935, long:  -97.9630, imageName: "image3"),
    Item(name: "Sadler House Apartments", neighborhood: "1271 Sadler Drive", desc: "Sadler House is a modern apartment community in San Marcos, Texas, offering one- and two-bedroom units ranging from 674 to 1,126 square feet. Each apartment features high ceilings, stainless steel appliances, granite countertops, and full-size washer and dryer units. Residents can enjoy amenities such as a swimming pool with a sundeck, a fitness center, a dog park with a pet hydration station, and a playground. The community is conveniently located near Rodriguez Elementary, Miller Middle School, and San Marcos High School. Additionally, Sadler House is within walking distance of Central Texas Medical Center and offers easy access to local shopping centers and parks.", lat: 29.8505, long: -97.9497, imageName: "image4"),
    Item(name: "Treehouse Apartments", neighborhood: "800 N LBJ Drive", desc: "Treehouse Apartments, located at 800 N LBJ Dr in San Marcos, Texas, offers one- and two-bedroom units ranging from 413 to 770 square feet. Each apartment features custom cabinetry, a kitchen appliance package, and faux hardwood flooring in common living areas. Furnished options are available, including a bed frame and mattress, desk, chair, dresser, nightstand, couch, coffee table, end table, and entertainment stand. Residents can enjoy amenities such as a sparkling swimming pool, picnic area with grills, and a 24-hour on-site clothes care facility. The community is conveniently located across from Texas State University, within walking distance to campus, local eateries, and the San Marcos River.", lat: 29.8832, long: -97.9402, imageName: "image5")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var theTable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }

    @IBOutlet weak var mapView: MKMapView!
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      
      //Add image references
                let image = UIImage(named: item.imageName)
                cell?.imageView?.image = image
                cell?.imageView?.layer.cornerRadius = 10
                cell?.imageView?.layer.borderWidth = 5
                cell?.imageView?.layer.borderColor = UIColor.white.cgColor
      return cell!
  }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let item = data[indexPath.row]
       performSegue(withIdentifier: "ShowDetailSegue", sender: item)
     
   }
    // add this function to original ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                // Pass the selected item to the detail view controller
                detailViewController.item = selectedItem
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        //add this code in viewDidLoad function in the original ViewController, below the self statements

           //set center, zoom level and region of the map
               let coordinate = CLLocationCoordinate2D(latitude: 29.8832, longitude: -97.9402)
               let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
               mapView.setRegion(region, animated: true)
               
            // loop through the items in the dataset and place them on the map
                for item in data {
                   let annotation = MKPointAnnotation()
                   let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                   annotation.coordinate = eachCoordinate
                       annotation.title = item.name
                       mapView.addAnnotation(annotation)
                       }
    }


}

