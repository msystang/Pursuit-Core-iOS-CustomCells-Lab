import UIKit

class ViewController: UIViewController {
    
    var users = [User]() {
        didSet{
            userTableView.reloadData()
       }
   }
    
    lazy var userTableView: UITableView = {
        let theTableView = UITableView()
        theTableView.dataSource = self
        theTableView.delegate = self
    
//        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
//        theTableView.register(nib, forCellReuseIdentifier: "userTVC")
//
        theTableView.register(UserTableViewCell.self, forCellReuseIdentifier: "userTVC")
        
        return theTableView
    }()
    
    private func loadUsers() {
        UsersFetchingService.manager.getUsers { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .failure(let error):
                        print(error)
                case .success(let data):
                    self.users = data
                }
            }
        }
    }
    
    func setConstraints() {
        self.userTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.userTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.userTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.userTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.userTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        self.view.addSubview(userTableView)
        setConstraints()
        loadUsers()
        super.viewDidLoad()
       
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        guard let cell = self.userTableView.dequeueReusableCell(withIdentifier: "userTVC", for: indexPath) as? UserTableViewCell else {return UITableViewCell()}
        cell.nameLabel.text = "\(user.name.title) \(user.name.first) \(user.name.last)"
        return cell
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let storyboard = UIStoryboard(name: "ViewController", bundle: nil)
       let linkingVC = storyboard.instantiateViewController(withIdentifier: "userDetail")
       self.navigationController?.pushViewController(linkingVC, animated: true)
       }
   }
