//
//  ViewController.swift
//  Project16
//
//  Created by Pablo Rodrigues on 25/11/2022.
//
import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    let mapType = ["Hybrid": MKMapType.hybrid, "MutedStandard": MKMapType.mutedStandard, "HybridFlyover": MKMapType.hybridFlyover, "Satelite" : MKMapType.satellite , "SateliteFlyover": MKMapType.satelliteFlyover]
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.", wikipediaURL: "https://nl.wikipedia.org/wiki/london")
        
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Fonded over a thousand years ago", wikipediaURL: "https://nl.wikipedia.org/wiki/oslo")
        
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", wikipediaURL: "https://nl.wikipedia.org/wiki/paris")
      
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", wikipediaURL: "https://nl.wikipedia.org/wiki/rome")
      
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", wikipediaURL: "https://nl.wikipedia.org/wiki/washington")
        
        mapView.addAnnotations([london, paris, oslo, rome, washington])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map Type", style: .plain, target: self, action: #selector(selectedMap))
        
     
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.leftCalloutAccessoryView = btn
          
            
            if let pinView = annotationView as? MKMarkerAnnotationView {
                pinView.markerTintColor = UIColor(red: 0, green: 0.7, blue: 0, alpha: 1)
        } else {
            annotationView?.annotation = annotation
            
            
            }
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let capitalName = capital.title
        let capitalInfo = capital.info
      
        let ac = UIAlertController(title: capitalName, message: capitalInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Wikipedia", style: .default,handler: { (action) in
            self.openWikipedia(url: capital.wikipediaURL)
        }))
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
    
                                
    @objc func selectedMap() {
        let ac = UIAlertController(title: "MapStyles", message: "Change your MapStyle", preferredStyle: .alert)
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        for mapType in Array(mapType.keys).sorted(by: < ) {
            ac.addAction(UIAlertAction(title: mapType, style: .default, handler: mapTypeSelected))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func mapTypeSelected(action: UIAlertAction) {
        guard let title = action.title else { return }
        
        if let type = mapType[title] {
            mapView.mapType = type
        }
    }
    
    func openWikipedia(url: String) {
    if let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? MyWebViewController {
        vc.website = url
    navigationController?.pushViewController(vc, animated: true)
            }
        }
    
  
}
                                   
    




