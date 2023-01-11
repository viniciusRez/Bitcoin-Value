//
//  CriptoTableViewController.swift
//  CriptoInfo
//
//  Created by Vinicius Rezende on 11/01/23.
//

import UIKit
import Foundation

class CriptoTableViewController: UITableViewController {
    var criptoViewModel: RequestViewModel?
    var listOfCripto:[cripto] = []
    override func viewDidLoad() {
        self.tableView.delegate = self
        self.refreshControl
        self.criptoViewModel = RequestViewModel()
        self.criptoViewModel?.getDados(completion: { apiData in
            
            self.listOfCripto = apiData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        })
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func refresh(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false){ timer in
            self.criptoViewModel?.getDados(completion: { apiData in
                
                self.listOfCripto = apiData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }

            })
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(listOfCripto.count)
        return listOfCripto.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let coin = self.listOfCripto[indexPath.row]
        self.performSegue(withIdentifier: "seeDetail", sender: coin)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeDetail" {
            let destino = segue.destination as! ViewController
            destino.coin = sender as? cripto
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coin", for: indexPath)

//        // Configure the cell...
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.groupingSeparator = "."
        nf.decimalSeparator = ","
        cell.textLabel?.text = self.listOfCripto[indexPath.row].symbol

        if let sellValue = nf.string(from: NSNumber(value: self.listOfCripto[indexPath.row].sellValue)){
            cell.detailTextLabel?.text = "Sell value: " + sellValue
             
        }
        print(cell.detailTextLabel?.text)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
