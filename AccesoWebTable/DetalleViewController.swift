//
//  DetalleViewController.swift
//  AccesoWebTable
//
//  Created by Ricardo Roman Landeros on 06/12/15.
//  Copyright © 2015 lagunahack. All rights reserved.
//

import UIKit
import CoreData

class DetalleViewController: UIViewController {
    
    var books = [NSManagedObject]()

    @IBOutlet weak var autorText: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let libro = books[0]
        let name  = libro.valueForKey("name")
        let autor = libro.valueForKey("autor")
        let urlImgeText = libro.valueForKey("image") as? String
        print("\(name),\(autor), \(urlImgeText)")
        nameText.text = name as? String
        autorText.text = autor as? String
        if urlImgeText !=  ""
        {
        let urlImage = NSURL(string: urlImgeText!)
        let datosImagen: NSData? = NSData(contentsOfURL: urlImage!)
        let image = UIImage(data: datosImagen!)
        self.image.image = image
        }
        else
        {
            let image = UIImage(named: "no.png")
            self.image.image = image
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
