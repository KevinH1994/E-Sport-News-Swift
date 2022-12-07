import UIKit

class ConversationTableViewCell: UITableViewCell {

    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

