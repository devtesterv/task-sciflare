
import UIKit

class listTableViewCell: UITableViewCell {
    
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var apiService = ApiService()
    private var urlString: String = ""
    
    //MARK: - Setup movie values
    func setCellWithValuesOf(_ movie: Unicorns) {
        updateUI(id: movie.id, name: movie.name, colour: movie.colour, age: movie.age)
    }
    
    // MARK: - Update the UI Views
    private func updateUI(id:String?, name:String?, colour:String?, age:String?) {
        
        self.idLbl.text = id
        self.nameLabel.text = name
        self.ageLbl.text = age
//        self.view?.backgroundColor = UIColor(named: "\(colour)")

    }
 
}
