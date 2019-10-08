import UIKit

class ViewController: UIViewController {
    
    var users = [User]() {
        didSet{
            userTableView.reloadData()
       }
   }
    
    lazy var userTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
    
//        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
//        theTableView.register(nib, forCellReuseIdentifier: "userTVC")
//
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "userCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(userTableView)
        setConstraints()
        loadUsers()
    }
    
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
    
    private func setConstraints() {
        self.userTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.userTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.userTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.userTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.userTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        
        guard let cell = self.userTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        
        cell.nameLabel.text = "\(user.name.title) \(user.name.first) \(user.name.last)"
        
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UserDetailViewController()

        self.navigationController?.pushViewController(detailVC, animated: true)

    }
}
