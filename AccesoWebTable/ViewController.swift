//
//  ViewController.swift
//  AccesoWebTable
//
//  Created by Ricardo Roman Landeros on 06/12/15.
//  Copyright © 2015 lagunahack. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
//    @IBOutlet var textISB: UITextField!
//    
//    @IBOutlet var textResultado: UITextView!
//    
//    @IBOutlet weak var lbNombreLibro: UILabel!
//    
//    @IBOutlet weak var ivImagenLibro: UIImageView!
    
    
    @IBOutlet weak var textISB: UITextField!
    
    @IBOutlet weak var textResultado: UITextView!
    
    @IBOutlet weak var lbNombreLibro: UILabel!
    
    @IBOutlet weak var ivImagenLibro: UIImageView!
    
    var name: String = ""
    var autor: String = ""
    var imageText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveBook(name: String, autor: String, image: String)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entityForName("Book", inManagedObjectContext: managedContext)
        
        let book = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        //3
        book.setValue(name, forKey: "name")
        book.setValue(autor, forKey: "autor")
        book.setValue(image, forKey: "image")
        
        //4
        do {
            try managedContext.save()
            //5
            print("datos guardados biennnnnnnnnn")
            //  people.append(person)
            
        } catch let error as NSError {
            
            print("No se salvo  \(error), \(error.userInfo)")
            
        }
    }

    @IBAction func buttonBuscar(sender: UIButton) {
            let text1 = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
            let urls = text1 + textISB.text!
            //let urls = "http://dia.ccm.itesm.mx/"
            let isbn: String = "ISBN:" + textISB.text!
            //print(urls)
            let url = NSURL(string: urls)
            let datos: NSData? = NSData(contentsOfURL: url!)
            if datos == nil
            {
                print("errrorr")
            }
                else
            {
                do{
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                let diccionario1 = json as! NSDictionary
                let diccionario2 = diccionario1[isbn] as! NSDictionary
                name = diccionario2["title"] as! NSString as String
                lbNombreLibro.text = name
                let arrayAutor = diccionario2["authors"] as! NSArray
                let dicAtores = arrayAutor[0] as! NSDictionary
                print("Aqui vienen lso autores")
                print(dicAtores["name"]!)
                autor = dicAtores["name"]! as! NSString as String
                textResultado.text = autor
                if diccionario2.valueForKey("cover") == nil
                {
                    print("No contiene imagen")
                    let image = UIImage(named: "no.png")
                    self.ivImagenLibro.image = image
                    imageText = "no tiene imagen"
                    print("\(name), \(autor), \(imageText)")
                   saveBook(name, autor: autor, image: imageText)
                }
                    else
                {
                    let dicImagen = diccionario2["cover"] as! NSDictionary
                    let urlImgeText = dicImagen["large"] as! NSString as String
                    imageText = urlImgeText
                    let urlImage = NSURL(string: urlImgeText)
                    let datosImagen: NSData? = NSData(contentsOfURL: urlImage!)
                    let image = UIImage(data: datosImagen!)
                    self.ivImagenLibro.image = image!
                    print("\(name), \(autor), \(imageText)")
                    saveBook(name, autor: autor, image: imageText)
                }
                
                //print("\(name), \(autor), \(imageText)")
                //saveBook(name, autor: autor, image: imageText)
                
                
            }
                catch _{
                        
                }
                //let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
                //textResultado.text = String(texto)
                //print(texto!)
            }
            
            }

}

