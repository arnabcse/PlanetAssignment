//
//  HomeViewController.swift
//  PlanetAssessment
//
//  Created by Arnab on 29/07/21.
//

import UIKit
import SystemConfiguration

class HomeViewController: UIViewController {
    
    @IBOutlet var btnDownload: UIButton!
    @IBOutlet var btnAnalysis: UIButton!
    @IBOutlet var btnViewAll: UIButton!
    
    var isDataDownloaded:Bool = false
    var homeViewModel: HomeViewModel!
    var homeValidationViewModel: HomeValidationViewModel!
    var arrPlanetVM = [HomeViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        isDataDownloaded = false
        self.homeValidationViewModel = HomeValidationViewModel(self)
        self.homeValidationViewModel.entityIsEmpty()
    }
    
    @IBAction func didTapDownloadBtn(_sender : AnyObject){
        if currentReachabilityStatus == .notReachable {
            self.showError(nil, message: "No Network in the Device! Connect Your Device to Network To Download!")
        } else {
            self.homeValidationViewModel.DeleteAllData()
            self.getData()
        }
    }
    
    func getData(){
        Service.shareInstance.getAllPlanetData { (planets, error) in
            if(error==nil){
                self.arrPlanetVM = planets?.map({ return HomeViewModel(planet: $0) }) ?? []
                if(self.arrPlanetVM.count > 0){
                    DispatchQueue.main.async {
                        self.showError(nil, message: "Data Successfully Downloaded from Server!")
                    }
                }
                self.homeValidationViewModel.entityIsEmpty()
            }else{
                DispatchQueue.main.async {
                    self.isDataDownloaded = false
                    self.showError(nil, message: "Unable To get data from Server!")
                }
            }
        }
    }
    
    @IBAction func didTapAnalysisBtn(_sender : AnyObject){
        
    }
    
    @IBAction func didTapViewAllBtn(_sender : AnyObject){
        if isDataDownloaded {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let destinationVC = storyboard.instantiateViewController(withIdentifier: "PlanetListViewController")
                self.navigationController?.pushViewController(destinationVC, animated: true)
        }else{
            self.showError(nil, message: "No Planet Data Downloaded, Please Download the Data Unsing Network!")
        }
    }
    
}

extension HomeViewController: HomeViewModelDelegate {
    func savePlanetsDataSuccess() {
        isDataDownloaded = true
    }
    
    func savePlanetsDataFailedWithMessage(_ message: String) {
        self.showError(nil, message: message)
        isDataDownloaded = false
    }
}


protocol Utilities {}
extension NSObject: Utilities {
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    var currentReachabilityStatus: ReachabilityStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            // The target host is not reachable.
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }
}
