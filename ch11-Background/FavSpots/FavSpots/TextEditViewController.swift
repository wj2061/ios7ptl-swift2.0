//
//  TextEditViewController.swift
//  FavSpots
//
//  Created by wj on 15/10/26.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit


struct kSpotConstant{
    static let spotKey = "kSpotKey"
}

class TextEditViewController: UIViewController {
    var spot:Spot?{
        didSet{
             configureView()
        }
    }

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        spot?.notes = textView.text
    }

    
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        print("\(__FUNCTION__)")
        super.encodeRestorableStateWithCoder(coder)
        if spot != nil{
        coder.ptl_encodeSpot(spot!, key: kSpotConstant.spotKey)
        }
    }
    
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        print("\(__FUNCTION__)")
        super.decodeRestorableStateWithCoder(coder)
        spot =  coder.ptl_decodeSpotForKey(kSpotConstant.spotKey)
    }
    

    
    func configureView(){
        textView?.text = spot?.notes
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
